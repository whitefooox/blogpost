import 'package:flutter/material.dart';

class TestPostPage extends StatelessWidget {
  const TestPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Main page!",
              style: TextStyle(
                fontSize: 40
              ),
            )
          ],
        ),
      ),
    );
  }
}