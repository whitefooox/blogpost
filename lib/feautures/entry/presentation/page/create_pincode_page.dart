import 'package:blogpost/core/widget/bw_button.dart';
import 'package:flutter/material.dart';

class CreatePincodePage extends StatelessWidget {
  const CreatePincodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    /*
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: GridView.count(
            padding: EdgeInsets.all(50),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 3,
            children: List.generate(12, (index) {
              switch (index) {
                case 9:
                  return BwButton(onPressed: () {  }, child: Icon(Icons.fingerprint, size: 30,));
                case 10:
                  return BwButton(onPressed: () {  }, child: Text(
                    "0",
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),);
                case 11:
                  return BwButton(onPressed: () {  }, child: Icon(Icons.backspace_outlined, size: 20,));
                default:
                  //return Text((index + 1).toString());
                  return BwButton(onPressed: () {  }, child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),);
              }
            })
          )
        )
      ),
    );
    */
  }

}