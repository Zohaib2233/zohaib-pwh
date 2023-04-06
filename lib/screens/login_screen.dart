import 'package:flutter/material.dart';
import 'package:auth_app1/customWidgets/text_field.dart';
import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:auth_app1/screens/profile_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputField(hintText: "Enter Your Email",),
              SizedBox(
                height: 8,
              ),
              InputField(hintText: "Enter Password"),
              SizedBox(
                height: 24,
              ),
            Button(buttonText:"Login",
                onPressed:(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>ProfileScreen()));
                }),
            ],
          ),
        ),
      ),
    );
  }
}




