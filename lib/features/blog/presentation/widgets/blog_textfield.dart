import 'package:flutter/material.dart';

class BlogScreenTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BlogScreenTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText cannot be empty';
        } else {
          return null;
        }
      },

      ///when we set max lines to null,the textfield extends itself when
      ///the line is filled and goes bottom
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
