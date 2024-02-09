import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/core/widget/bw_icon_button.dart';
import 'package:flutter/material.dart';

class LockKeyboard extends StatelessWidget {

  final Function(int) onNumberTap;
  final Function() onBackspaceTap;
  final Function()? onFingerprintTap;

  const LockKeyboard({
    super.key, 
    required this.onNumberTap,
    required this.onBackspaceTap,
    this.onFingerprintTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      primary: false,
      padding: const EdgeInsets.only(left: 50, right: 50),
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
              onNumberTap(index + 1);
            }, 
            text: '${index + 1}',
            fontSize: 25,
            shape: const CircleBorder(),
          );
        } else if (index == 9){
          if(onFingerprintTap != null){
            return BwIconButton(
              onPressed: (){
                onFingerprintTap!();
              }, 
              iconSize: 35,
              iconData: Icons.fingerprint,
              shape: const CircleBorder(),
            );
          } else {
            return Container();
          }
          
        } else if(index == 10){
          return BwButton(
            onPressed: (){
              onNumberTap(0);
            }, 
            text: '0',
            fontSize: 25,
            shape: const CircleBorder(),
          );
        } else {
          return BwIconButton(
            onPressed: (){
              onBackspaceTap();
            }, 
            iconSize: 25,
            iconData: Icons.backspace_outlined,
            shape: const CircleBorder(),
          );
        }
      }),
    );
  }
  
}