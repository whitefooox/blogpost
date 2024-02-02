import 'package:flutter/material.dart';

class BwButton extends StatelessWidget {

  final void Function() onPressed;
  final String text;
  final bool isEnabled;

  const BwButton({
    super.key, 
    required this.onPressed,
    required this.text,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: isEnabled ? Colors.white : Colors.black,
        foregroundColor: isEnabled ? Colors.white : Colors.black,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        side: const BorderSide(color: Colors.black),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: isEnabled ? Colors.black : Colors.white
        ),
      ),
    );
  }
}