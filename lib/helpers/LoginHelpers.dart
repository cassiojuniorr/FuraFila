import 'package:fura_fila/pagesCustomer/home_customer.dart';
import 'package:fura_fila/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginHelperUser {
  final AuthService _authService = AuthService();

  loginButton(email, password, context) async {
    try {
      await _authService.loginUser(
          email: email,
          password: password);

      String? userId = await _authService.getIdUser();
      print(userId);
      if (userId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        print("Login falhou: ID do usuário inválido");
      }
    } catch (e) {
      print("Erro durante o login: $e");
    }
  }
}