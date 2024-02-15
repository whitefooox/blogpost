import 'package:flutter/material.dart';

class BwInputField extends StatelessWidget {

  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final String labelText;
  final bool isHidden;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? initialValue;

  const BwInputField({
    super.key,
    required this.labelText,
    this.textController,
    this.validator,
    this.isHidden = false,
    this.keyboardType,
    this.maxLines,
    this.onChanged,
    this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
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