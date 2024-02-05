import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/core/widget/bw_icon_button.dart';
import 'package:blogpost/module/entry/presentation/widget/pin_progress.dart';
import 'package:flutter/material.dart';

class CreateLockPage extends StatefulWidget {
  const CreateLockPage({super.key});

  @override
  State<CreateLockPage> createState() => _CreateLockPageState();
}

class _CreateLockPageState extends State<CreateLockPage> {
  final pinLenght = 4;
  var currentPin = '';

  void enterNumber(int number){
    if(currentPin.length < pinLenght){
      setState(() {
        currentPin += number.toString();
      });
    }
    if(currentPin.length == pinLenght){
      
    }
  }

  void deleteLastNumber(){
    if(currentPin.isNotEmpty){
      setState(() {
        currentPin = currentPin.substring(0, currentPin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              PinProgress(pinLenght: pinLenght, currentCount: currentPin.length),
              SizedBox(height: 20,),
              GridView(
                primary: false,
                padding: EdgeInsets.only(left: 50, right: 50),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20
                ),
                children: List.generate(12, (index) {
                  if(index <= 8){
                    return BwButton(
                      onPressed: (){
                        enterNumber(index + 1);
                      }, 
                      text: '${index + 1}',
                      //useSide: false,
                      fontSize: 25,
                      shape: CircleBorder(
                        //side: BorderSide(color: Colors.black)
                      ),
                    );
                  } else if (index == 9){
                    return BwIconButton(
                      onPressed: (){}, 
                      iconSize: 35,
                      iconData: Icons.fingerprint,
                      shape: CircleBorder(
                        //side: BorderSide(color: Colors.black)
                      ),
                    );
                  } else if(index == 10){
                    return BwButton(
                      onPressed: (){
                        enterNumber(0);
                      }, 
                      text: '0',
                      //useSide: false,
                      fontSize: 25,
                      shape: CircleBorder(
                        //side: BorderSide(color: Colors.black)
                      ),
                    );
                  } else {
                    return BwIconButton(
                      onPressed: (){
                        deleteLastNumber();
                      }, 
                      iconSize: 25,
                      iconData: Icons.backspace_outlined,
                      shape: CircleBorder(
                        //side: BorderSide(color: Colors.black)
                      ),
                    );
                  }
                }),
              )
            ],
          ),
        )
      ),
    );
  }
}