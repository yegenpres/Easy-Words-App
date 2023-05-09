import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/view_model/autetification_state.dart';

enum _Messages {
  wrongCredential,
  emptyEmail,
  shortPassword,
  noConnectionWithServer,
  passwordNotEqual,
  wrongEmail;

  @override
  String toString() {
    switch (this) {
      case _Messages.wrongCredential:
        return 'Wrong email or password';
      case _Messages.emptyEmail:
        return 'Email field is empty';
      case _Messages.wrongEmail:
        return 'Wrong email';
      case _Messages.shortPassword:
        return "Password should contain minimum 6 symbols";
      case _Messages.noConnectionWithServer:
        return "No connection with server";
      case _Messages.passwordNotEqual:
        return "Passwords not equal";
    }
  }
}

class PageRegistration extends ConsumerStatefulWidget {
  const PageRegistration({Key? key}) : super(key: key);

  @override
  ConsumerState<PageRegistration> createState() => _RegistrationState();
}

class _RegistrationState extends ConsumerState<PageRegistration> {
  final _form = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  String errorMessage = "";

  String? errorConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Platform.isAndroid
                  ? AppBar(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    )
                  : const CupertinoNavigationBar(),

              Center(
                child: Container(
                  height: 200,
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      color: context.appColors.text,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Visibility(
                visible: errorMessage.isNotEmpty,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

              Container(
                width: 530,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: context.appColors.textFormColor,
                ),
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (input) {
                          if (input == null) {
                            return _Messages.emptyEmail.toString();
                          }
                          if (input.contains(
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
                            return _Messages.wrongEmail.toString();
                          }
                          return null;
                        },
                        controller: emailController, // Controller for Username
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            contentPadding: EdgeInsets.all(20)),
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return _Messages.shortPassword.toString();
                          }
                          return null;
                        },

                        controller:
                            passwordController, // Controller for Password
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            contentPadding: const EdgeInsets.all(20),
                            // Adding the visibility icon to toggle visibility of the password field
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            )),
                        obscureText: _isObscure,
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return _Messages.shortPassword.toString();
                          }
                          if (confirmPasswordController.text !=
                              passwordController.text) {
                            return _Messages.passwordNotEqual.toString();
                          }
                          return null;
                        },

                        controller:
                            confirmPasswordController, // Controller for Password
                        decoration: InputDecoration(
                          errorText: errorConfirmPassword,
                          border: InputBorder.none,
                          hintText: "Confirm password",
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        obscureText: _isObscure,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 570,
                height: 70,
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: const Text(
                    "Submit",
                  ),
                  onPressed: () async {
                    if (!_form.currentState!.validate()) return;

                    ref
                        .read(
                      SignInWithState.signInWithEmail(
                          [emailController.text, passwordController.text]),
                    )
                        //todo may be can be problem with navigation need test
                        .then(
                      (state) {
                        state.maybeMap(
                            errorPasswordOrEmail: (err) {
                              setState(() {
                                errorMessage =
                                    _Messages.wrongCredential.toString();
                              });
                            },
                            systemError: (err) {
                              setState(() {
                                errorMessage =
                                    _Messages.noConnectionWithServer.toString();
                              });
                            },
                            registered: (Registered value) {},
                            orElse: () {
                              setState(() {
                                errorMessage =
                                    _Messages.noConnectionWithServer.toString();
                              });
                            });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
