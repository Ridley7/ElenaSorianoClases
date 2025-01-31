import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({
    super.key,
    required this.labelText,
    required this.controller
  });

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin:const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText
        ),
      ),
    );
  }
}
