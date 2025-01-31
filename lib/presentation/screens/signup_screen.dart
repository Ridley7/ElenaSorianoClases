import 'package:elenasorianoclases/presentation/widgets/background_login.dart';
import 'package:elenasorianoclases/presentation/widgets/text_field_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static String name = "sign-up";

  @override
  Widget build(BuildContext context) {

    final TextEditingController nombreController = TextEditingController();
    final TextEditingController apellidoController = TextEditingController();
    final TextEditingController correoController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundLogin(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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

                  const SizedBox(height: 50,),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      "REGISTRO",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                          fontSize: 36
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  TextFieldLogin(
                      controller: nombreController,
                      labelText: "Nombre"
                  ),

                  const SizedBox(height: 12),

                  TextFieldLogin(
                      controller: apellidoController,
                      labelText: "Apellido"
                  ),

                  const SizedBox(height: 12),

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
                      onPressed: () {

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
                          "REGISTRARSE",
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
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()))
                        context.go("/login_signup");
                      },
                      child: const Text(
                        "¿Ya tienes cuenta? Entra",
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

