import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fura_fila/pagesCompany/home_company.dart';
import 'package:fura_fila/pagesCustomer/home_customer.dart';
import 'package:fura_fila/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/core/snack_bar.dart';

class LoginHelperUser {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  loginButtonUser(email, password, context) async {
    try {
      print("Exeecccccc user");
      await _authService.loginUser(email: email, password: password);

      String? userId = await _authService.getIdUser();
      print(userId);
      if (userId != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePageCustomer()),
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

  loginButtonCompany(email, password, context) async {
    try {
      print("Exeecccccc empresa");
      await _authService.loginUser(email: email, password: password);

      String? eID = await _authService.getIdUser();
      print(eID);
      if (eID != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeCompany()),
          (route) => false,
        );
      } else {
        print("Login Empresarial Falhou: ID da empresa inválido");
        showSnackBar(
            context: context,
            text: "Login Empresarial Falhou: ID da empresa inválido");
      }
    } catch (e) {
      print("Erro durante o login da empresa: $e");
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

  Future<bool> checkIfCompany(
      String email, String password, BuildContext context) async {
    try {
      if (!validLogin(email, password)) {
        showSnackBar(
          context: context,
          text: "Por favor, preencha todos os campos.",
        );
        return false;
      }

      final companyQuery = await _firestore
          .collection('company')
          .where('emailCompany', isEqualTo: email)
          .get();
      print("tessssssssssst ${companyQuery.docs.isNotEmpty}");

      return companyQuery.docs.isNotEmpty;
    } catch (e) {
      print("Erro ao verificar coleção 'company': $e");
      return false;
    }
  }
}
