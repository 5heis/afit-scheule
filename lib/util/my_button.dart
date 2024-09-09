import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: Colors.white,
      onPressed: onPressed,
      color: Color(0xFF5E17EB),
      child: Text(text),
    );
  }
}
