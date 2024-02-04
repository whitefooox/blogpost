import 'package:blogpost/feautures/entry/presentation/widget/pin_progress.dart';
import 'package:flutter/material.dart';

class CreateLockPage extends StatelessWidget {
  const CreateLockPage({super.key});

  final lenght = 4;
  final int current = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment:MainAxisAlignment.center,
          children: [
            PinProgress(pinLenght: 4, currentCount: 2),
            
          ],
        )
      ),
    );
  }

}