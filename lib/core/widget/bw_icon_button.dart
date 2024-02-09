import 'package:flutter/material.dart';

class BwIconButton extends StatelessWidget {

  final void Function() onPressed;
  final bool isEnabled;
  final OutlinedBorder shape;
  final IconData iconData;
  final double iconSize;

  const BwIconButton({
    super.key, 
    required this.onPressed,
    this.isEnabled = true,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)), side: BorderSide(color: Colors.black)),
    required this.iconData,
    this.iconSize = 30
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        size: iconSize,
        color: isEnabled ? Colors.black : Colors.white,
      ),
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: isEnabled ? Colors.white : Colors.black,
        shape: shape,
      ),
    );
  }
}