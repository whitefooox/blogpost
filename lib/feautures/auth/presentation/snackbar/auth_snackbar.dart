import 'package:flutter/material.dart';

class AuthSnackBars {
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

  static const unauthenticatedSnackBar = SnackBar(
    backgroundColor: Colors.black,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Invalid email or password",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red
            ),
          ),
          SizedBox(width: 10,),
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 30,
          )
        ],
    )
  );
}