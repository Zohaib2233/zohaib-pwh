import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app1/customWidgets/text_field.dart';
import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:auth_app1/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                height: 60,
              ),
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputField(
                hintText: "Enter First Name",
                isPassword: false,
              ),
              SizedBox(
                height: 8,
              ),
              InputField(
                hintText: "Enter Last Name",
                isPassword: false,
              ),
              SizedBox(
                height: 8,
              ),
              InputField(
                hintText: "Enter Your Email",
                controller: _emailController,
                isPassword: false,
              ),
              SizedBox(
                height: 8,
              ),
              InputField(
                  hintText: "Enter Password",
                  controller: _passwordController,
                  isPassword: true),
              SizedBox(
                height: 24,
              ),
              Button(
                  buttonText: "Register",
                  onPressed: () async {
                    final String email = _emailController.text.trim();
                    final String password = _passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      return;
                    }

                    if (password.length < 6) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Password is weak'),
                            content: Text(
                                'Your password must be at least 6 characters long.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    try {
                      UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      print('Registered user: ${userCredential.user}');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have Account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>LoginScreen()));
                  }, child: Text("Log In"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
