import 'package:flutter/material.dart';

class BuildErrorText extends StatelessWidget {
  final String message;
  
  const BuildErrorText({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error: $message'),
    );
  }
}
