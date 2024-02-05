import 'package:flutter/material.dart';

class AuthTextLink extends StatelessWidget {

  final String text;
  final void Function() onTap;

  const AuthTextLink({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}