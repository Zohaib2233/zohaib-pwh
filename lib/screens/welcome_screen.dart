import 'package:flutter/material.dart';
import 'package:auth_app1/screens/login_screen.dart';
import 'package:auth_app1/screens/registration_screen.dart';
import 'package:auth_app1/customWidgets/material_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [

                Text("Welcome",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),)
              ],
            ),
            Column(
              children: const [
                Text("To"),
                Text("Client information",
                style: TextStyle(color: Colors.black,fontSize: 14,
                ),),

              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Button(buttonText: "Login",
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>new LoginScreen()));
            },),
            Button(buttonText: "Register",
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>RegistrationScreen()));
            },)
          ],
        ),
      ),
    );
  }
}
