import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {

  final TextEditingController textController;
  final String? Function(String?)? validator;
  final String labelText;
  final bool isHidden;

  const AuthInputField({
    super.key,
    required this.labelText,
    required this.textController,
    this.validator,
    this.isHidden = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHidden,
      controller: textController,
      style: const TextStyle(
        fontSize: 16
      ),
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}