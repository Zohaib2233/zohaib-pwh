import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/get_users_response_model.dart';

class DetailScreen extends StatefulWidget {
  UserObject? user;
   DetailScreen({Key? key,this.user}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Card(
            margin: EdgeInsets.all(10),
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "First Name :"+
                              "${widget.user?.firstName??""}",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Last  Name :"+
                              "${widget.user?.lastName??""}",
                          style: TextStyle(color: Colors.black),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Gender :"+
                              "${widget.user?.gender??""}",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Email :"+
                              "${widget.user?.email??""}",
                          style: TextStyle(color: Colors.black),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "IP address :"+
                              "${widget.user?.ipAddress??""}",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 10,),


                      ],
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }


}
