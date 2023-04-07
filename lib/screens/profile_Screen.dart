import 'package:auth_app1/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Profile Screen"),actions: [
        Icon(Icons.close)
      ],backgroundColor: Colors.lightBlueAccent),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: Colors.green),
            child: TextButton(
              onPressed: (){
                  signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Text("Log Out",style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
