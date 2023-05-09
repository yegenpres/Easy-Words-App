import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/router.dart';
import 'package:wordsapp/view/log_in_sign_in/widget_sign_in_with.dart';
import 'package:wordsapp/view/privacy_policy.dart';
import 'package:wordsapp/view_model/autetification_state.dart';

enum _Messages {
  wrongCredential,
  emptyEmail,
  resetLinkSent,
  shortPassword,
  noConnectionWithServer,
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
      case _Messages.resetLinkSent:
        return 'Reset link hase sent on your email';
      case _Messages.shortPassword:
        return "Password should contain minimum 6 symbols";
      case _Messages.noConnectionWithServer:
        return "No connection with server";
    }
  }
}

class PageAutentification extends ConsumerStatefulWidget {
  const PageAutentification({Key? key}) : super(key: key);

  @override
  ConsumerState<PageAutentification> createState() =>
      _AutentificationScreenState();
}

class _AutentificationScreenState extends ConsumerState<PageAutentification> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  String errorMessage = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      child: SingleChildScrollView(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 400,
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
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
                        style: TextStyle(
                          color:
                              errorMessage == _Messages.resetLinkSent.toString()
                                  ? Colors.green
                                  : Colors.red,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 530,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: context.appColors.textFormColor),
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
                          controller:
                              emailController, // Controller for Username
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
                      ],
                    ),
                  ),

                  Container(
                    width: 570,
                    height: 70,
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onLongPress: () {
                        SignInWithState.testLogIn(ref);
                      },
                      child: ElevatedButton(
                        child: const Text(
                          "Login",
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          ref
                              .read(
                            SignInWithState.logInWithEmail([
                              emailController.text,
                              passwordController.text
                            ]),
                          )
                              .then((state) {
                            state.map(
                                noLogedIn: (value) => log("noLogedIn"),
                                logedIn: (LogedIn responce) {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                errorPasswordOrEmail: (errorPasswordOrEmail) {
                                  setState(() {
                                    errorMessage =
                                        _Messages.wrongCredential.toString();
                                  });
                                },
                                systemError: (SystemError res) {
                                  setState(() {
                                    errorMessage = _Messages
                                        .noConnectionWithServer
                                        .toString();
                                  });
                                },
                                registered: (Registered value) {});
                          });
                        },
                      ),
                    ),
                  ),
                  const WidgetSignInWith(),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: const Text("Registration",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue)),
                          onTap: () {
                            context.go(Routes.registration.name);
                          })),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue)),
                      onTap: () {
                        if (emailController.text.isEmpty) {
                          setState(() {
                            errorMessage = _Messages.emptyEmail.toString();
                          });
                          return;
                        }

                        if (!emailController.text.contains(
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
                          setState(() {
                            errorMessage = _Messages.wrongEmail.toString();
                          });
                          return;
                        }

                        ref
                            .read(SignInWithState.resetPassword(
                                emailController.text))
                            .then((value) {
                          value.maybeMap(
                            registered: (value) {
                              setState(() {
                                errorMessage =
                                    _Messages.resetLinkSent.toString();
                              });
                            },
                            orElse: () {
                              setState(() {
                                errorMessage =
                                    _Messages.noConnectionWithServer.toString();
                              });
                            },
                          );
                        });
                      },
                    ),
                  ),

                  Text(" By signing in to this app, you agree with ",
                      style: TextStyle(color: context.appColors.text)),

                  const PolicyasAndTerms()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
