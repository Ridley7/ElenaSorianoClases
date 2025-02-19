import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/domain/repositories/user_repository.dart';
import 'package:elenasorianoclases/infrastructure/repositories/student_repository_implementation.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/login_register_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/background_login.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/text_field_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static String name = "login-sign-out";

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {

  final TextEditingController correoController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool loading = true;

  Future<void> loginUser() async{

    try{
      if(correoController.text.isEmpty || passController.text.isEmpty){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No pueden haber campos vacios"),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      LoginRegisterRepository loginRegister = ref.read(loginRegisterRepositoryProvider);
      UserCredential credential = await loginRegister.loginUser(correoController.text, passController.text);

      //Comprobamos diferentes datos del estudiante
      StudentRepositoryImplementation repositoriyStudents = ref.read(studentRepositoryProvider);
      StudentModel studentModel = await repositoriyStudents.getStudent(credential.user!.uid);

      //Si tiene el rol de profesor, descargamos la lista de estudiantes
      if(studentModel.rol == "lecturer"){
        print("Descargando estudiantes");
        List<StudentModel> listaEstudiantes = await repositoriyStudents.getAllStudents();
        //Rellenamos el provider de estudiantes
        ref.read(listStudentsProvider.notifier).init(listaEstudiantes);
      }


      if(studentModel.access){
        print("Este estudiante tiene acceso");
      }else{
        print("No tiene acceso");
      }

      context.go("/home");
    }on FirebaseAuthException catch(e){

      String message = "Error no detectado";

      if(e.code == 'user-not-found'){
        message = 'No user found for that email.';
      }else if(e.code == 'wrong-password'){
        message = 'Wrong password provided for that user.';
      }else if(e.code == 'invalid-email'){
        message = "El email no corresponde a una cuenta de correo";
      }else if(e.code == 'invalid-credential'){
        message = "Credenciales invalidas";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error inesperado"),
          duration: const Duration(seconds: 3),
        ),
      );
    }finally{
      OverlayLoadingView.hide();
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkSession();
    });
  }

  void checkSession() async{
    //Comprobamos si el usuario esta logueado
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){

      //Tenemos que traer la información del usuario. ¿Como? ¿con el correo? No, con el uid.
      print("El usuario es: ${user.uid}");

      //Traemos las clases de la BD
      List<ClassModel> listaClases = await ref.read(classRepositoryProvider).getAllClass();
      //Rellenamos el provider con esas clases
      ref.read(listClassProvider.notifier).setClass(listaClases);

      //Obtenemos todos los datos del usuario con id = uid
      StudentRepositoryImplementation repositoriyStudents = ref.read(studentRepositoryProvider);
      StudentModel studentModel = await repositoriyStudents.getStudent(user.uid);

      //Si tiene el rol de profesor, descargamos la lista de estudiantes
      if(studentModel.rol == "lecturer"){
        print("Descargando estudiantes");
        List<StudentModel> listaEstudiantes = await repositoriyStudents.getAllStudents();
        //Rellenamos el provider de estudiantes
        ref.read(listStudentsProvider.notifier).init(listaEstudiantes);
      }

      if(studentModel.access){
        print("Este estudiante tiene acceso");
      }else{
        print("No tiene acceso");
      }


      context.go('/home');
    }else{
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? const Center(child: CircularProgressIndicator(),)
      :BackgroundLogin(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 50,),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Image.asset("assets/images/logo_elena.png"),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 100,),


                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                        fontSize: 36
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                TextFieldLogin(
                  controller: correoController,
                  labelText: "Correo"
                ),

                const SizedBox(height: 12),

                TextFieldLogin(
                    controller: passController,
                    labelText: "Contraseña"
                ),

                const SizedBox(height: 24),

                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: FilledButton(
                    onPressed: () async {
                      OverlayLoadingView.show(context);
                      await loginUser();
                      OverlayLoadingView.hide();
                    },
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero)
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFBDC4),
                                Color(0xFFFFE9EB)
                              ]
                          )

                      ),
                      child: const Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                          color: Colors.black38
                        ),
                      ),
                    ),
                  ),
                ),


                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                    context.go("/sign_up");
                    },
                    child: const Text(
                      "¿No tienes cuenta? Registrate",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        )
      ),
    );
  }
}


