import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/login_register_repository_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/background_login.dart';
import 'package:elenasorianoclases/presentation/widgets/buttons/main_button.dart';
import 'package:elenasorianoclases/presentation/widgets/buttons/text_line_button.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/text_field_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecoveryPassScreen extends ConsumerStatefulWidget {
  const RecoveryPassScreen({super.key});

  static String name = "recovery-pass";

  @override
  RecoveryPassScreenState createState() => RecoveryPassScreenState();
}

class RecoveryPassScreenState extends ConsumerState<RecoveryPassScreen> {

  final TextEditingController correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundLogin(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text("Introduce tu correo electrónico"),
              const SizedBox(height: 40,),
              TextFieldLogin(
                controller: correoController,
                labelText: "Correo",
              ),

              MainButton(
                  textButton: "Recuperar",
                  onClick: () async {

                    final email = correoController.text.trim();

                    if (email.isEmpty) {
                      snackbarWidget(
                        context,
                        'Introduce tu correo electrónico',
                      );
                      return;
                    }

                    OverlayLoadingView.show(context);

                    String message;

                    try{
                      await ref.read(
                          loginRegisterRepositoryProvider).
                      recoveryPass(email);

                      message = "Si existe una cuenta asociada a ese correo, recibirás un enlace para cambiar al contraseña";

                    } on RecoveryPassException catch (error){

                      message =
                          error.message ??
                              'No se ha podido enviar el correo de recuperación.';

                    } catch (_) {

                      message = "No se ha podido enviar el correo de recuperación";

                    } finally {
                      OverlayLoadingView.hide();
                    }

                    if(!context.mounted) return;

                    snackbarWidget(context, message);

                  }
              ),

              TextLineButton(
                  textButton: "Atrás",
                  onClick: (){
                    context.pop();
                  }
              ),



            ],
          ),
        )
      ),
    );
  }
}
