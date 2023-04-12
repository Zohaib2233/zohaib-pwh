import 'package:auth_app1/customWidgets/material_button.dart';
import 'package:auth_app1/customWidgets/text_field.dart';
import 'package:auth_app1/utils/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    final User user = FirebaseAuth.instance.currentUser!;
    getData(user.uid);
    super.initState();
  }

  final AuthCredential credential = EmailAuthProvider.credential(
    email: FirebaseAuth.instance.currentUser!.email.toString(),
    password: 'currentPassword',
  );

  // user.reauthenticateWithCredential(credential);
  String _firstName = "";
  String _lastName = "";
  String _country = "";
  String _docId="";

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _firstNameController.text = _firstName;
    _lastNameController.text = _lastName;
    _countryController.text = _country;
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
                  hintText: "Enter Your Email",
                  controller: _firstNameController,
                  isPassword: false,
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  hintText: "Enter Last Name",
                  controller: _lastNameController,
                  isPassword: false,
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  hintText: "What is your country",
                  isPassword: false,
                  controller: _countryController,
                ),
                SizedBox(
                  height: 24,
                ),
                Button(
                    buttonText: "Update",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final String firstname = _firstNameController.text.trim();
                        final String lastname = _lastNameController.text.trim();
                        final String country = _countryController.text.trim();


                        if (firstname.isEmpty || lastname.isEmpty || country.isEmpty) {
                          return;
                        }

                          final User user = FirebaseAuth.instance.currentUser!;
                          final dataToUpdate = {'first_name': firstname, 'last_name': lastname,'country':country};
                          await updateNestedDocument(user.uid, dataToUpdate);



                        }
                      }
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData(String userId) {
    // Call the Firestore reference to get data
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('data')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(querySnapshot.docs.first.reference.id);

        setState(() {
          _docId=querySnapshot.docs.first.reference.id;
          _firstName = doc["first_name"];
          _lastName = doc["last_name"];
          _country = doc["country"];
        });
      });
    }).catchError((error) => print("Failed to get data: $error"));
  }

  Future<void> updateNestedDocument( String userId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("data")
          .doc(_docId)
          .update(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: const Text(
          'Data Updated Successfully',
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
      ));

    } catch (e) {
      // Handle any errors here
      print('Error updating nested document: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: const Text(
          "Error updating document",
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
      ));

    }
  }


}
