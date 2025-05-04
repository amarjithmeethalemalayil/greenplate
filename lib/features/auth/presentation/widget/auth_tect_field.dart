import 'package:flutter/material.dart';

class AuthTectField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const AuthTectField({
    super.key,
    required this.obscureText,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
