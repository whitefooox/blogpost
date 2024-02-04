import 'package:flutter/material.dart';

class PinProgress extends StatelessWidget {

  final int pinLenght;
  final int currentCount;

  const PinProgress({
    super.key,
    required this.pinLenght,
    required this.currentCount
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLenght, (index) {
        return Container(
          margin: const EdgeInsets.all(10),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (index + 1 <= currentCount) ? Colors.black : Color.fromARGB(255, 205, 205, 205)
            //border: Border.all(color: Colors.black, width: 2)
          ),
        );
      })
    );
  }

}