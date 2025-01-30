import 'package:flutter/material.dart';

InputDecoration inputDecorationAddStudent(){
  return InputDecoration(
  labelText: "Nombre",
  border: OutlineInputBorder( // Border normal
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Colors.blue, width: 2),
  ),
  enabledBorder: OutlineInputBorder( // Borde cuando el campo NO está enfocado
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
  ),
  focusedBorder: OutlineInputBorder( // Borde cuando el campo ESTÁ enfocado
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0xFFFFBDC4), width: 2.5),
  ),
contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Espaciado interno
);
}