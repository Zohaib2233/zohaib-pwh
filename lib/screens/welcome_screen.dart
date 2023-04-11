import 'package:auth_app1/screens/profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:auth_app1/screens/login_screen.dart';
import 'package:auth_app1/screens/registration_screen.dart';
import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => destination), (Route<dynamic> route) => predict);
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    bool? isLoggedIn = GetStorage().read("isLoggedIn");
    if (isLoggedIn ?? false) {
      Future.delayed(const Duration(seconds: 2),(){
        pushAndRemoveUntil(context, const ProfileScreen(), false);
      });

    }
    super.initState();
  }

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
              pushAndRemoveUntil(context, const LoginScreen(), false);
            },),
            Button(buttonText: "Register",
            onPressed: (){
              pushAndRemoveUntil(context, const RegistrationScreen(), false);
            },)
          ],
        ),
      ),
    );
  }
}
