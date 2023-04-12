import 'package:auth_app1/screens/welcome_screen.dart';
import 'package:auth_app1/utils/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app1/customWidgets/text_field.dart';
import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:auth_app1/screens/profile_Screen.dart';
import 'package:auth_app1/screens/registration_screen.dart';

import 'package:get_storage/get_storage.dart';
import 'package:auth_app1/utils/utils.dart';
import 'package:toast/toast.dart';

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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
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
                height: height(context) * 0.15,
              ),
              Container(
                height: height(context) * 0.3,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: height(context) * 0.07,
              ),
              InputField(
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  isValidate: _validateEmail,
                  isPassword: false),
              SizedBox(
                height: 8,
              ),
              InputField(
                  hintText: "Enter Password",
                  controller: _passwordController,
                  isValidate: _validatePassword,
                  isPassword: true),
              SizedBox(
                height: height(context) * 0.03,
              ),
              Button(
                  buttonText: "Login",
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    final String email = _emailController.text.trim();
                    final String password = _passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      return;
                    }
                    try {
                      GetStorage().write("logInUserEmail", email);
                      GetStorage().write("logInUserPassword", password);
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      print('Logged in user: ${userCredential.user}');
                      GetStorage().write("isLoggedIn", true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Toast.show("No user found for that email.",duration: Toast.lengthLong);
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        Toast.show("Wrong password provided for that user.",duration: Toast.lengthLong);
                        print('Wrong password provided for that user.');
                      }
                    } catch (e) {
                      Toast.show(e.toString(),duration: Toast.lengthLong);
                      print(e);
                    }
                  }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have Account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()));
                      },
                      child: Text("Register"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
