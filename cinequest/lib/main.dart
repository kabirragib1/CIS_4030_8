import 'package:flutter/material.dart';
import 'package:cinequest/sign_in_sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineQuest',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 3, 35, 90), 
      ),
      home: const SignInSignUpScreen(),
    );
  }
}
