import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_app1/screens/welcome_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'screens/profile_Screen.dart';

void main() async {
  print("init");
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  print("WidgetsFlutterBinding.ensureInitialized()");
  await Firebase.initializeApp();
  print("await Firebase.initializeApp()");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54)
        )
      ),
      home: const WelcomeScreen(),
    );
  }
}


