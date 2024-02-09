import 'dart:developer';

import 'package:blogpost/module/entry/domain/interactor/lock_interactor.dart';
import 'package:blogpost/module/entry/presentation/widget/lock_keyboard.dart';
import 'package:blogpost/module/entry/presentation/widget/pin_progress.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EnterLockPage extends StatefulWidget {
  const EnterLockPage({super.key});

  @override
  State<EnterLockPage> createState() => _EnterLockPageState();
}

class _EnterLockPageState extends State<EnterLockPage> {

  final lockInteractor = GetIt.instance.get<LockInteractor>();

  final pinMaxLength = 4;
  var pin = '';

  void enterNumber(int number){
    setState(() {
      if (pin.length < pinMaxLength) {
        pin += number.toString();
      } 
    });
    if(pin.length == pinMaxLength){
      if(lockInteractor.authenticateWithPin(pin)){
        Navigator.pushReplacementNamed(context, "/posts");
      } else {
        setState(() {
          pin = '';
        });
      }
      //Navigator.pushReplacementNamed(context, "/posts");
    }
  }

  void deleteLastNumber(){
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your pin code",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 60,),
              PinProgress(
                pinLenght: pinMaxLength, 
                currentCount: pin.length
              ),
              const SizedBox(height: 20,),
              LockKeyboard(
                onNumberTap: enterNumber, 
                onBackspaceTap: deleteLastNumber,
                onFingerprintTap: (lockInteractor.hasFingerprint()) ? () async {
                  if(await lockInteractor.authenticateWithFingerprint()){
                    Navigator.pushReplacementNamed(context, "/posts");
                  }
                } : null
              )
            ],
          ),
        )
    );
  }
}