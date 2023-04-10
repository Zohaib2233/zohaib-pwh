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
    return DefaultTabController(
    length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Profile Screen"),
            actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(

              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Colors.blue),
              child: TextButton(
                onPressed: (){
                  signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Text("Log Out",style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],backgroundColor: Colors.lightBlueAccent),
        body: Column(
          children: [
            TabBar(
              labelColor: Colors.purple,
              tabs: [
              Tab(
                text: "Show All",
                icon: Icon(Icons.all_inbox),
              ),
              Tab(
                text: "Show Favurites",
                icon: Icon(Icons.favorite),
              ),
            ],
            indicatorColor: Colors.purple,),
            Expanded(
              child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: Text("Item 1",style:TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: Text("Item 1",style:TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: Text("Item 1",style:TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: Text("Item 1",style:TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.greenAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            child: Text("Item 1",style:TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),

                    ],

                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          child: Text("Item 1",style:TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          child: Text("Item 1",style:TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          child: Text("Item 1",style:TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          child: Text("Item 1",style:TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          child: Text("Item 1",style:TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),

                  ],

                )
              ]),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lightBlueAccent,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting"),

          ],
        ),
    ));}
}
