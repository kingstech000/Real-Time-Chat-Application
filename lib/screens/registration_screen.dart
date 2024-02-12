// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, must_be_immutable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'custom_textBox.dart';
import 'package:flashchat/screens/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  bool showspinnner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinnner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const SizedBox(
                height: 48.0,
              ),
              CustomTextBox(
                hideText: false,
                hinttext: 'Enter your email',
                onchanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextBox(
                hideText: true,
                hinttext: 'Enter your password',
                onchanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedShapedButton(
                text: 'Register',
                buttonColor: Colors.blueAccent,
                onpressed: () async {
                  setState(() {
                    showspinnner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != Null) {
                      Navigator.pushNamed(context, '/chat');
                    }
                    setState(() {
                      showspinnner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
