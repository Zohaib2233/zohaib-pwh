import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    @required this.hintText,
    this.controller,
    required this.isPassword,
  });

  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value){

      },
      style: TextStyle(color: Colors.black),
      controller: controller,

      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlueAccent,width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent,width: 2),
              borderRadius: BorderRadius.all(Radius.circular(32.0))
          )
      ),
    );
  }
}