import 'package:auth_app1/utils/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app1/customWidgets/text_field.dart';
import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:auth_app1/screens/profile_Screen.dart';
import 'package:auth_app1/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              InputField(hintText: "Enter Your Email",
                  controller: _emailController,
              isValidate: validateEmail,
              isPassword: false),
              SizedBox(
                height: 8,
              ),
              InputField(hintText: "Enter Password",controller: _passwordController,
                  isValidate: validatePassword,
                  isPassword: true),
              SizedBox(
                height: 24,
              ),
            Button(buttonText:"Login",
                onPressed:()async{
                  if (_formKey.currentState!.validate()) {
                  final String email = _emailController.text.trim();
                  final String password = _passwordController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    return;
                  }
                  try {
                    UserCredential userCredential =
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print('Logged in user: ${userCredential.user}');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));

                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  } catch (e) {
                    print(e);
                  }
                }}),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have Account?"),
                  TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                      (context)=>RegistrationScreen()));
                  }, child: Text("Register"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




