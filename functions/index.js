
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
/*
exports.getCosas = onRequest( async (req, res) =>  {
    
 try {

    //Obtenemos todos los tokens de los usuarios que podrian estar interesados
    const tokensSnapshot = await admin.firestore().collection("user_tokens").get();
    const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

    if(tokens.length === 0){
      console.log("No hay tokens para enviar notificacion");
      res.send("No hay tokens");
      return;
    }

    //Creamos el mensaje para la notificacion
    const message = {
      notification:{
        title: "¡Plaza disponible!",
        body: "Un estudiante ha dejado una clase"
      },
      tokens: tokens,
    };

    //Enviamos la notificacion
    try{
      const response = await getMessaging().sendEachForMulticast(message);
      console.log("Notificaciones enviadas con exitos:", response);
    } catch(error){
      console.error("Error enviando notificaciones:", error);
    }

    res.send(`Notificación Push enviada`);


} catch (error) {
    console.error("Error obteniendo estudiantes:", error);
    res.status(500).send("Error al obtener estudiantes");
}
});
*/

exports.notifyAvailableSpot = onDocumentUpdated("clases/{claseId}", async (event) => {

    //Accedemos a los datos que se han producido antes y despues de la actualizacion
    const beforeData = event.data.before.data();
    const afterData = event.data.after.data();

    //Si alguno de los dos es nulo, no hacemos nada
    if(!beforeData || !afterData) return;

    //Obtenemos la lista de estudiantes de antes y despues de la actualizacion
    const beforeStudents = beforeData.listStudent || [];
    const afterStudents = afterData.listStudent || [];

    //Si el tamaño de la lista de estudiantes ha disminuido, alguien se ha desapuntado
    if(afterStudents.length < beforeStudents.length){

        // Obtener todos los tokens de usuarios que podrían estar interesados
            const tokensSnapshot = await admin.firestore().collection("user_tokens").get();
            const tokens = tokensSnapshot.docs.map(doc => doc.data().token);

            if (tokens.length === 0) {
              console.log("No hay tokens para enviar notificación.");
              return;
            }

            // Obtenemos la fecha
            const classDate = afterData.date || "---";

            // Crear el mensaje de notificación
            // Extraemos
            const message = {
              notification: {
                title: "¡Plaza disponible!",
                body: `Un estudiante dejó la clase del día ${classDate}.\n¡Aprovecha y reserva tu lugar!`,
              },
              data: {
                    ruta: "/schedule",
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
