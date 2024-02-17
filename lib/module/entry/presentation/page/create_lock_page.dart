import 'dart:developer';

import 'package:blogpost/module/entry/domain/interactor/lock_interactor.dart';
import 'package:blogpost/module/entry/presentation/widget/lock_keyboard.dart';
import 'package:blogpost/module/entry/presentation/widget/pin_progress.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateLockPage extends StatefulWidget {

  const CreateLockPage({
    super.key,
  });

  @override
  State<CreateLockPage> createState() => _CreateLockPageState();
}

class _CreateLockPageState extends State<CreateLockPage> {

  final lockInteractor = GetIt.instance.get<LockInteractor>();

  final pinLength = 4;
  var firstPin = '';
  var secondPin = '';
  bool isSettingSecondPin = false;

  @override
  void initState() {
    super.initState();
  }

  void enterNumber(int number){
    setState(() {
      if (!isSettingSecondPin && firstPin.length < pinLength) {
        firstPin += number.toString();
        if (firstPin.length == pinLength) {
          isSettingSecondPin = true;
        }
      } else if (isSettingSecondPin && secondPin.length < pinLength) {
        secondPin += number.toString();
        if (secondPin.length == pinLength) {
          if (firstPin == secondPin) {
            saveLockInfo();
          } else {
            log("Pin mismatch, please try again.");
            firstPin = '';
            secondPin = '';
            isSettingSecondPin = false;
          }
        }
      }
    });
  }

  void saveLockInfo() async {
    lockInteractor.enablePin(firstPin);
    final enableBiometry = _showUseBiometryDialog();
    if(await enableBiometry) lockInteractor.enableFingerprint();
    if(mounted) Navigator.pushReplacementNamed(context, "/posts");
  }

  void deleteLastNumber(){
    if (!isSettingSecondPin) {
      setState(() {
        if (firstPin.isNotEmpty) {
          firstPin = firstPin.substring(0, firstPin.length - 1);
        }
      });
    } else {
      setState(() {
        if (secondPin.isNotEmpty) {
          secondPin = secondPin.substring(0, secondPin.length - 1);
        }
      });
    }
  }

  Future<bool> _showUseBiometryDialog() async {
    final result = await showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fingerprint login'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enable entry with biometry?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text(
                isSettingSecondPin ? "Confirm your pin code" : "Enter your pin code",
                style: const TextStyle(
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 60,),
              PinProgress(
                pinLenght: pinLength, 
                currentCount: isSettingSecondPin ? secondPin.length : firstPin.length
              ),
              const SizedBox(height: 20,),
              LockKeyboard(
                onNumberTap: enterNumber, 
                onBackspaceTap: deleteLastNumber,
              )
            ],
          ),
        )
    );
  }
}