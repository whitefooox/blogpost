import 'dart:developer';

import 'package:blogpost/core/resource/resource.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_button.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_input_field.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_text_link.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  bool _isPasswordValid(String email) {
    return RegExp(r'^.{8,}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 50,),
                  Image.asset(
                    Resource.logo,
                    height: 100, 
                  ),
                  const SizedBox(height: 25,),
                  const Text("Welcome to BlogPost!", 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black
                      ),
                  ),
                  const SizedBox(height: 25,),
                  AuthInputField(
                    labelText: 'Email',
                    textController: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!_isEmailValid(value)) {
                        return 'Enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  AuthInputField(
                    labelText: 'Password',
                    textController: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (!_isPasswordValid(value)) {
                        return 'Enter a valid password';
                      } else {
                        return null;
                      }
                    },
                    isHidden: true,
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 60,
                    child: AuthButton(onPressed: () {
                      _formKey.currentState!.validate();
                      log(_emailController.text);
                    }, text: "Sign in")
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "No account?\t",
                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),
                          AuthTextLink(
                            text: "Sign up", 
                            onTap: (){
                              log("sign up");
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      AuthTextLink(
                        text: "Continue without an account", 
                        onTap: (){
                          log("Continue without an account");
                        },
                      ),
                      const SizedBox(height: 100,)
                    ],
                  )
                ],
              ),
            ),
          ),
        ))
    );
  }
}