import 'dart:developer';

import 'package:blogpost/core/resource/resource.dart';
import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/feautures/auth/presentation/snackbar/auth_snackbar.dart';
import 'package:blogpost/feautures/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/feautures/auth/presentation/validation/auth_validator.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_input_field.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state.authProcessStatus == AuthProcessStatus.loading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AuthSnackBars.loadingSnackBar);
        } else if (state.authProcessStatus == AuthProcessStatus.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AuthSnackBars.errorSnackBar(state.errorMessage!));
        } else if (state.authProcessStatus == AuthProcessStatus.unauthorized) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AuthSnackBars.unauthenticatedSnackBar);
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      Resource.logo,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Welcome to BlogPost!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AuthInputField(
                      labelText: 'Email',
                      textController: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        } else if (!AuthValidator.isEmailValid(value)) {
                          return 'Enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthInputField(
                      labelText: 'Password',
                      textController: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        } else if (!AuthValidator.isPasswordValid(value)) {
                          return 'Enter a valid password';
                        } else {
                          return null;
                        }
                      },
                      isHidden: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        bloc: authBloc,
                        builder: (_, state) {
                          return BwButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              log(state.runtimeType.toString());
                              if (_formKey.currentState!.validate()) {
                                authBloc.add(AuthSignInEvent(
                                  email: _emailController.text, 
                                  password: _passwordController.text
                                ));
                              }
                            },
                            isEnabled: state.authProcessStatus != AuthProcessStatus.loading,
                            text: "Sign in",
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "No account?\t",
                              style: TextStyle(fontSize: 14),
                            ),
                            AuthTextLink(
                              text: "Sign up",
                              onTap: () {
                                Navigator.pushReplacementNamed(context, "/signup");
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthTextLink(
                          text: "Continue without an account",
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/posts");
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
