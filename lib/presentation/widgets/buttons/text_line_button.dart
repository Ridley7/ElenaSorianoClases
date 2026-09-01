import 'package:flutter/material.dart';

class TextLineButton extends StatelessWidget {
  const TextLineButton({
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
      child: GestureDetector(
        onTap: onClick,
        child: Text(
          textButton,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),
        ),
      ),
    );
  }
}
