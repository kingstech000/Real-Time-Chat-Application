// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace, await_only_futures, unrelated_type_equality_checks, avoid_print, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/custom_widget.dart';
import 'package:flutter/material.dart';
import 'custom_textBox.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  User? loggeduser;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              CustomTextBox(
                hideText: false,
                hinttext: 'Enter your email ',
                onchanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomTextBox(
                hideText: true,
                hinttext: 'Enter your password',
                onchanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedShapedButton(
                text: 'Log In',
                buttonColor: Colors.lightBlueAccent,
                onpressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.currentUser;
                    loggeduser = user;
                    if (loggeduser != Null) {
                      final existingUser =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (existingUser != Null) {
                        Navigator.pushNamed(context, '/chat');
                        setState(() {
                          showSpinner = false;
                        });
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Error",
                        desc: "Invalid username or password",
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            child: Text(
                              "Try again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ).show();
                    });
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
