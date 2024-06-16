// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          
          filled: true,
          fillColor: Color.fromRGBO(255, 193, 193, 1),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 193, 193, 1)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(245, 91, 75, 0.6))),
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromRGBO(255, 254, 254, 0.8)),
        ),
      ),
    );
  }
}