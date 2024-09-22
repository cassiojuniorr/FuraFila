import 'package:flutter/material.dart';
import 'package:fura_fila/pagesCompany/register_image_company.dart';
import 'package:fura_fila/pagesCustomer/home_customer.dart';
import 'package:fura_fila/pagesCustomer/login_customer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fura_fila/pagesCustomer/profile_customer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp(
    title: 'sdada',
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  const MyApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileCustomer(),
      debugShowCheckedModeBanner: false,
    );
  }
}
