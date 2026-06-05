import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        labelText: hintText,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
