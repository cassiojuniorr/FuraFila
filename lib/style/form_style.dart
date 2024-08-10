import 'package:flutter/material.dart';

class FormStyle {
  InputDecoration fieldStyle(text) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: text,
      hintStyle: const TextStyle(
        color: Color.fromRGBO(166, 166, 166, 1),
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
