import 'package:flutter/material.dart';

class MyTxtfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTxtfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
        ),
        fillColor: Colors.grey[400],
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey)
      ),
    );
  }
}
