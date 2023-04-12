
import 'package:auth_app1/screens/edit_profile_screen.dart';
import 'package:auth_app1/screens/home_screen.dart';
import 'package:auth_app1/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
  static const List<Widget> screens = <Widget>[
    HomeScreen(),
   EditProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Main Screen"),
            actions: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: TextButton(
                    onPressed: () {
                      GetStorage().remove("isLoggedIn");
                      signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text("Log Out",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.lightBlueAccent,
            selectedItemColor: Colors.white,
           currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit), label: "Edit Profile"),
            ],

          ),
        ));
  }
}
