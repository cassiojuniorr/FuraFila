import 'package:fura_fila/pagesCustomer/home_customer.dart';
import 'package:fura_fila/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/core/snack_bar.dart';

class LoginHelperUser {
  final AuthService _authService = AuthService();

  loginButton(email, password, context) async {
    try {
      await _authService.loginUser(email: email, password: password);

      String? userId = await _authService.getIdUser();
      print(userId);
      if (userId != null) {        
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePageCustomer()),
            (route) => false,
          );
      } else {
        print("Login falhou: ID do usuário inválido");
        showSnackBar(
            context: context, text: "Login falhou: ID do usuário inválido");
      }
    } catch (e) {
      print("Erro durante o login: $e");
      showSnackBar(context: context, text: "Error $e");
    }
  }

  Future<void> resetPassword(
    String email,
    BuildContext context,
  ) async {
    if (email.isNotEmpty) {
      try {
        await _authService.resetPassword(email);
        showSnackBar(
            context: context,
            text: 'Email de recuperação enviado para $email',
            isErro: false);
      } catch (e) {
        showSnackBar(
            context: context, text: 'Erro ao enviar email de recuperação');
      }
    } else {
      showSnackBar(context: context, text: 'Por favor, insira seu e-mail');
    }
  }

  bool validLogin(
    String email,
    String password,
  ) {
    return email.isNotEmpty && password.isNotEmpty;
  }
}
