//Poner en marcha el emulador: firebase emulators:start
//Detener el emulador:

/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
/*
const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
*/
const {onDocumentUpdated} = require("firebase-functions/v2/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const admin = require("firebase-admin");

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

admin.initializeApp();

exports.helloWorld = onRequest((req, res) => {
  res.send("¡Hola Mundo desde Firebase!");
});

exports.getTime = onRequest((req, res) => {
  const currentTime = new Date().toISOString();
  logger.info(`La hora actual es: ${currentTime}`);
  res.send(`Hora actual: ${currentTime}`);
});

exports.getCosas = onRequest( async (req, res) =>  {
    
 try {
    const studentsSnapshot = await admin.firestore().collection("estudiantes").get();
    const students = studentsSnapshot.docs.map(doc => doc.data().name);

    res.send(`Cantidad: ${students.length}, Nombres: ${students.join(", ")}`);

    //Obtenemos todos los tokens de los usuarios que podrian estar interesados
    //const tokensSnapshot = await admin.firestore().collection("user_tokens").get();
    //const tok

    /*
     // Obtener todos los tokens de usuarios que podrían estar interesados
    const tokensSnapshot = await admin.firestore().collection("userTokens").get();
    const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

    if (tokens.length === 0) {
      console.log("No hay tokens para enviar notificación.");
      return;
    }

    // Crear el mensaje de notificación
    const message = {
      notification: {
        title: "¡Plaza disponible!",
        body: `Un estudiante dejó la clase ${event.params.claseId}. ¡Aprovecha y reserva tu lugar!`,
      },
      tokens: tokens,
    };

    // Enviar la notificación
    try {
      const response = await getMessaging().sendEachForMulticast(message);
      console.log("Notificaciones enviadas con éxito:", response);
    } catch (error) {
      console.error("Error enviando notificaciones:", error);
    }
    */




} catch (error) {
    console.error("Error obteniendo estudiantes:", error);
    res.status(500).send("Error al obtener estudiantes");
}

});

/*
const {onDocumentUpdated} = require("firebase-functions/v2/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const admin = require("firebase-admin");

admin.initializeApp();

exports.notifyAvailableSpot = onDocumentUpdated("clases/{claseId}", async (event) => {
  const beforeData = event.data.before.data();
  const afterData = event.data.after.data();

  if (!beforeData || !afterData) return;

  const beforeStudents = beforeData.listStudent || [];
  const afterStudents = afterData.listStudent || [];

  // Si el tamaño de la lista de estudiantes ha disminuido, alguien se desapuntó
  if (afterStudents.length < beforeStudents.length) {
    console.log("Un estudiante se desapuntó, enviando notificación...");

    // Obtener todos los tokens de usuarios que podrían estar interesados
    const tokensSnapshot = await admin.firestore().collection("userTokens").get();
    const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

    if (tokens.length === 0) {
      console.log("No hay tokens para enviar notificación.");
      return;
    }

    // Crear el mensaje de notificación
    const message = {
      notification: {
        title: "¡Plaza disponible!",
        body: `Un estudiante dejó la clase ${event.params.claseId}. ¡Aprovecha y reserva tu lugar!`,
      },
      tokens: tokens,
    };

    // Enviar la notificación
    try {
      const response = await getMessaging().sendEachForMulticast(message);
      console.log("Notificaciones enviadas con éxito:", response);
    } catch (error) {
      console.error("Error enviando notificaciones:", error);
    }
  }
});

*/