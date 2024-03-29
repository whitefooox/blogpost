import 'package:flutter/material.dart';

class BwButton extends StatelessWidget {

  final void Function() onPressed;
  final String text;
  final bool isEnabled;
  final OutlinedBorder shape;
  final double fontSize;

  const BwButton({
    super.key, 
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)), side: BorderSide(color: Colors.black)),
    this.fontSize = 16
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: isEnabled ? Colors.white : Colors.black,
        shape: shape,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: isEnabled ? Colors.black : Colors.white
        ),
      ),
    );
  }
}