// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyButton extends StatelessWidget {
  MyButton({required this.title, required this.color, required this.onPressed, required this.textColor});

  final Color color;
  final String title;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        minWidth: 200,
        height: 46,
        child: Text(title,
        style: GoogleFonts.ubuntu(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w800
          ),
        )
      )
    );
  }
}