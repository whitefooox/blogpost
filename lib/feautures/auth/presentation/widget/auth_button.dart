import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {

  final void Function() onPressed;
  final String text;

  const AuthButton({
    super.key, 
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        side: const BorderSide(color: Colors.black),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16
        ),
      )
    );
  }
}