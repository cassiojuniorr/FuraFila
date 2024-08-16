import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context, required String text, bool isErro = true}) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: (isErro) ? Colors.red : Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
