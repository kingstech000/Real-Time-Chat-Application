// ignore_for_file: unused_import, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'firebase_options.dart';

void main() async {
  try {
    print("WidgetsFlutterBinding process is taken place");
    WidgetsFlutterBinding.ensureInitialized();
    print("Successfully initailized");
    if (Platform.isAndroid) {
      print("Inintailizing app");
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("This process was successful");
    }
    runApp(FlashChat());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: const Color.fromARGB(137, 2, 2, 2)),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          '/chat': (context) => ChatScreen(),
        });
  }
}
