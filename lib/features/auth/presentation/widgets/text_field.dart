import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    ///we use text form field instead of text field cuz it has validator
    ///argument that can be used for controlling inputs validation
    return TextFormField(
      controller: controller,
      validator: (value) {
        if(value!.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
