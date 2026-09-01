import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.textButton,
    required this.onClick
  });

  final String textButton;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: FilledButton(
        onPressed: onClick,
        /*
          onPressed: () async {
          OverlayLoadingView.show(context);
          await loginUser();
          OverlayLoadingView.hide();
        },
        */
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
          child: Text(
            textButton,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38
            ),
          ),
        ),
      ),
    );
  }
}
