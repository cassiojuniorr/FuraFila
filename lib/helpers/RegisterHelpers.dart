import 'package:fura_fila/core/snack_bar.dart';
import 'package:fura_fila/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterHelpers {
  Future<void> singUp() async {}
}

class RegisterHelpersUser extends RegisterHelpers {
  final AuthService _authService = AuthService();

  Future<void> singUpRegister(
    String name,
    String email,
    String password,
    String passwordConfirm,
    BuildContext context,
  ) async {
    if (password == passwordConfirm) {
      try {
        String? erro = await _authService.singUser(
          name: name,
          password: password,
          email: email,
        );

        if (erro != null) {
          showSnackBar(context: context, text: erro);
        } else {
          showSnackBar(
            context: context,
            text: "Cadastro efetuado com sucesso!",
            isErro: false,
          );
          Navigator.pop(context);
        }
      } catch (e) {
        showSnackBar(context: context, text: "Erro ao realizar cadastro");
      }
    } else {
      showSnackBar(context: context, text: "Senhas não conferem");
    }
  }

  bool validForm(
    String name,
    String email,
    String password,
    String passwordConfirm,
  ) {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        password.isNotEmpty &&
        password == passwordConfirm;
  }
}
