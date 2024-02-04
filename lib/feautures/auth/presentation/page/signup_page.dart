import 'dart:developer';

import 'package:blogpost/core/resource/resource.dart';
import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/feautures/auth/presentation/snackbar/auth_snackbar.dart';
import 'package:blogpost/feautures/auth/presentation/state/cubit/auth_cubit.dart';
import 'package:blogpost/feautures/auth/presentation/validation/auth_validator.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_input_field.dart';
import 'package:blogpost/feautures/auth/presentation/widget/auth_text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authCubit = BlocProvider.of<AuthCubit>(context);

    return BlocListener<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state) {
        if (state is AuthLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AuthSnackBars.loadingSnackBar);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AuthSnackBars.errorSnackBar(state.message));
        } else if (state is AuthUnauthenticated) {
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
                    AuthInputField(
                      labelText: 'Confirm password',
                      textController: _passwordConfirmController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        } else if (!AuthValidator.isPasswordValid(value)) {
                          return 'Enter a valid password';
                        } else if (_passwordConfirmController.text !=
                            _passwordController.text) {
                          return 'Password doesn\'t match';
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
                        child: BlocBuilder<AuthCubit, AuthState>(
                          bloc: authCubit,
                          builder: (context, state) {
                            return BwButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                log(state.runtimeType.toString());
                                if (_formKey.currentState!.validate()) {
                                  authCubit.signUp(_emailController.text,
                                    _passwordController.text);
                                }
                                
                              },
                              isEnabled: state is! AuthLoading,
                              text: "Sign up",
                            );
                          },
                        )),
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
                              "Do you have an account?\t",
                              style: TextStyle(fontSize: 14),
                            ),
                            AuthTextLink(
                              text: "Sign in",
                              onTap: () {
                                Navigator.pushReplacementNamed(context, "/signin");
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
