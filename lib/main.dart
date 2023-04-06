import 'package:flutter/material.dart';
import 'package:auth_app1/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54)
        )
      ),
      home: const WelcomeScreen(),
    );
  }
}


