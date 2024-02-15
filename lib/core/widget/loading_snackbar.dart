import 'package:flutter/material.dart';

class LoadingSnackBars {
  static const loadingSnackBar = SnackBar(
    backgroundColor: Colors.black,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
          SizedBox(width: 20,),
          CircularProgressIndicator(
            color: Colors.white,
          )
        ],
    )
  );

  static SnackBar errorSnackBar(String message){
    return SnackBar(
      duration: const Duration(seconds: 1),
    backgroundColor: Colors.black,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red
            ),
          ),
          const SizedBox(width: 10,),
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 30,
          )
        ],
      )
    );
  }

  static const successSnackBar = SnackBar(
    duration: Duration(seconds: 1),
    backgroundColor: Colors.black,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Success",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green
            ),
          ),
          SizedBox(width: 20,),
          Icon(
            Icons.check,
            color: Colors.green,
            size: 30
          )
        ],
    )
  );
}