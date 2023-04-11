import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app1/customWidgets/text_field.dart';
import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:auth_app1/screens/login_screen.dart';
import 'package:auth_app1/utils/validation.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  controller: _firstname,
                  hintText: "Enter Your First Name",
                  isPassword: false,
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _lastname,
                  hintText: "Enter Your Last Name",
                  isPassword: false,
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _country,
                  hintText: "Enter Your Country",
                  isPassword: false,
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  isValidate: validateEmail,
                  isPassword: false,
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                    hintText: "Enter Password",
                    controller: _passwordController,
                    isValidate: validatePassword,
                    isPassword: true),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  hintText: "Enter Confirm Password",
                  isPassword: true,
                  controller: _confirmPasswordController,
                  isValidate: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                Button(
                    buttonText: "Register",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final String email = _emailController.text.trim();
                        final String password = _passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          return;
                        }

                        try {
                          UserCredential userCredential =
                              await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          if (userCredential.user?.uid != null) {
                            await addData(userCredential.user?.uid ?? "",
                                _firstname.text, _lastname.text, _country.text);
                          }
                          print('Registered user: ${userCredential.user}');

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: const Text(
                                'The account already exists for that email.',
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: const Duration(seconds: 1),
                            ));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Log In"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addData(
      String userId, String first_name, String last_name, String country) {
    // Call the Firestore reference to add data
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('data')
        .add({
          'first_name': first_name,
          'last_name': last_name,
          'country': country
        })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add data: $error"));
  }
}
