import 'package:flutter/material.dart';

class FormStyle {
  InputDecoration fieldStyle(text) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white, width: 3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
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

  InputDecoration fieldSearchStyle(text) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color.fromRGBO(46, 10, 96, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: Color.fromRGBO(46, 10, 96, 1), width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: "Ex.: Bar X Y Z",
        prefixIcon: const Icon(
          Icons.search,
          color: Color.fromRGBO(46, 10, 96, 1),
        ),
        hintStyle: const TextStyle(
          color: Color.fromRGBO(46, 10, 96, 1),
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(46, 10, 96, 1),
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  InputDecoration fieldStyleLabel(text) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.white, width: 3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.red),
      ),
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    );
  }

  ButtonStyle fieldButtonTags() {
    return ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(46, 10, 96, 1),
        side: const BorderSide(
            width: 4.0, color: Color.fromRGBO(255, 255, 255, 1)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        shadowColor: Colors.black);
  }

  TextStyle fieldTextTags(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 20;
    double fontSize = screenWidth < 400 ? baseFontSize * 1 : baseFontSize;

    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle fieldCompanyName(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = 20;
    double fontSize = screenWidth < 600 ? baseFontSize * 1 : baseFontSize;

    return TextStyle(
      fontSize: fontSize,
      color: const Color.fromRGBO(46, 10, 96, 1),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle fieldCompanyTag() {
    return const TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(46, 10, 96, 1),
      fontWeight: FontWeight.bold,
    );
  }
}
