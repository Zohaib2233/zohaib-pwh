import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/get_users_response_model.dart';
import 'detail_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserObject> userList = [];
  List<UserObject> userFavList = [];
  bool isFav = false;
  bool isLoad = false;

  Future<void> fetchPost(Function callBack) async {
    isLoad = true;
    final response = await http.get(Uri.parse('https://my.api.mockaroo.com/users.json?key=cae17ac0'));
    if (response.statusCode == 200) {
      print("object");
      List jsonList = json.decode(response.body.toString()) as List;

      List myList = jsonList
          .map((jsonElement) => UserObject.fromJson(jsonElement))
          .toList();

      setState(() {
        userList = myList as List<UserObject>;
        isLoad = false;
      });
    } else {
      // If the response was umexpected, throw an error.s
      throw Exception('Failed to load Data');
    }
  }

  @override
  void initState() {
    fetchPost((bool isSuccess) {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Data Get From Server',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 1),
        ));
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          children: [
            const TabBar(
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
              indicatorColor: Colors.purple,
            ),
            isLoad?Expanded(child: Center(child: CircularProgressIndicator())):Expanded(
              child: TabBarView(children: [
                ListView.builder(
                    itemCount: userList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          UserObject? user = userList?[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(
                                        user: user,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                margin: EdgeInsets.all(10),
                                color: Colors.greenAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "First Name :" +
                                              "${userList?[index].firstName}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Gender :" +
                                              "${userList?[index].gender}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              UserObject? user =
                                              userList?[index];
                                              if (user != null) {
                                                if (userFavList
                                                    ?.contains(user) ??
                                                    false) {
                                                  userFavList?.remove(user);
                                                } else {
                                                  userFavList?.add(user);
                                                  print(user);
                                                }
                                              }
                                              setState(() {

                                              });
                                            },
                                            icon: isFav
                                                ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 24,
                                            )
                                                : const Icon(
                                              Icons.favorite_border,
                                              color: Colors.red,
                                              size: 24,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ListView.builder(
                    itemCount: userFavList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          UserObject? user = userList?[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(
                                        user: user,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                margin: EdgeInsets.all(10),
                                color: Colors.greenAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "First Name :" +
                                              "${userFavList?[index]
                                                  .firstName}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Gender :" +
                                              "${userFavList?[index].gender}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              UserObject? user =
                                              userList?[index];
                                              if (user != null) {
                                                if (userFavList
                                                    ?.contains(user) ??
                                                    false) {
                                                  userFavList?.remove(user);
                                                } else {
                                                  userFavList?.add(user);
                                                }
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 24,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ]),
            )
          ],
        ),
    );
  }
}
