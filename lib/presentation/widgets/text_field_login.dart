import 'package:flutter/material.dart';

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {

  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      alignment: Alignment.center,
      margin:const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        autocorrect: false,
        enableSuggestions: false,
        obscureText: _obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.labelText,
          suffixIcon: widget.obscureText ? IconButton(
              onPressed: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              )
          )
              : null
        ),
      ),
    );
  }
}
