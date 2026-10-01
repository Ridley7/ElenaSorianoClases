
const {onDocumentUpdated} = require("firebase-functions/v2/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Convierte un Timestamp de Firestore a una fecha legible
 * utilizando la zona horaria de España.
 *
 * Ejemplo:
 * 30/09/2026 a las 18:00
 */
function formatClassDate(timestamp) {
  if (!timestamp) return "---";

  const date = timestamp.toDate();

  const formattedDate = new Intl.DateTimeFormat("es-ES", {
    timeZone: "Europe/Madrid",
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  }).format(date);

  const formattedTime = new Intl.DateTimeFormat("es-ES", {
    timeZone: "Europe/Madrid",
    hour: "2-digit",
    minute: "2-digit",
    hourCycle: "h23",
  }).format(date);

  return `${formattedDate} a las ${formattedTime}`;
}


exports.notifyAvailableSpot = onDocumentUpdated(
    "clases/{claseId}",
    async (event) => {

      // Accedemos a los datos anteriores y posteriores a la actualización
      const beforeData = event.data.before.data();
      const afterData = event.data.after.data();

      // Si alguno de los dos es nulo, no hacemos nada
      if (!beforeData || !afterData) return;

      // Obtenemos la lista de estudiantes antes y después
      const beforeStudents = beforeData.listStudent || [];
      const afterStudents = afterData.listStudent || [];

      // Si el tamaño de la lista ha disminuido,
      // significa que alguien se ha desapuntado
      if (afterStudents.length < beforeStudents.length) {

        // Obtener todos los tokens de usuarios
        // que podrían estar interesados
        const tokensSnapshot = await admin
            .firestore()
            .collection("user_tokens")
            .get();

        const tokens = tokensSnapshot.docs
            .map((doc) => doc.data().token)
            .filter((token) => token);

        if (tokens.length === 0) {
          console.log("No hay tokens para enviar notificación.");
          return;
        }

        // Obtener y formatear la fecha de la clase
        const classDate = formatClassDate(afterData.timestamp);

        // Crear el mensaje de notificación
        const message = {
          notification: {
            title: "¡Plaza disponible!",
            body: `Un estudiante dejó la clase del ${classDate}.\n¡Aprovecha y reserva tu lugar!`,
          },
          data: {
            ruta: "/schedule",
          },
          tokens: tokens,
        };

        // Enviar la notificación
        try {

        if(process.env.FUNCTIONS_EMULATOR === "true"){
            console.log("EMULADOR: Notificación de que se enviaria:");
            console.log(JSON.stringify(message, null, 2));
            console.log("📅 Timestamp recibido:", afterData.timestamp);
            console.log("📅 Fecha formateada:", formatClassDate(afterData.timestamp));
            return;
        }

          const response = await getMessaging()
              .sendEachForMulticast(message);

          console.log(
              "Notificaciones enviadas con éxito:",
              response,
          );
        } catch (error) {
          console.error(
              "Error enviando notificaciones:",
              error,
          );
        }
      }
    },
);