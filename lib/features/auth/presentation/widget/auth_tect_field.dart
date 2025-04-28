import 'package:flutter/material.dart';

class AuthTectField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  const AuthTectField({
    super.key,
    required this.obscureText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
