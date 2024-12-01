import 'package:fura_fila/core/snack_bar.dart';
import 'package:fura_fila/pagesCompany/register_image__tag_company.dart';
import 'package:fura_fila/pagesCustomer/home_customer.dart';
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePageCustomer()),
            (route) => false,
          );
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
    bool? termos,
    BuildContext context,
  ) {
    if (password != passwordConfirm) {
      showSnackBar(context: context, text: "Senhas não conferem");
    }
    return name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        password.isNotEmpty &&
        password == passwordConfirm &&
        termos == true;
  }
}

class RegisterHelpersCompany extends RegisterHelpers {
  final AuthService _authService = AuthService();

  Future<void> registerCompany(
    String name,
    String email,
    String password,
    String passwordConfirm,
    String cnpj,
    String cep,
    String filiais,
    String queuePreference,
    BuildContext context,
  ) async {
    if (password == passwordConfirm) {
      try {
        String? erro = await _authService.singCompany(
          name: name,
          password: password,
          email: email,
          cnpj: cnpj,
          cep: cep,
          filiais: filiais,
          queuePreference: queuePreference,
        );

        if (erro != null) {
          showSnackBar(context: context, text: erro);
        } else {
          showSnackBar(
            context: context,
            text: "Cadastro da empresa efetuado com sucesso!",
            isErro: false,
          );          
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const RegisterImageTagCompany()),
            (route) => false,
          );
        }
      } catch (e) {
        showSnackBar(context: context, text: "Erro ao realizar cadastro");
      }
    } else {
      showSnackBar(context: context, text: "Senhas não conferem");
    }
  }

  bool validFormCompany(
    String name,
    String email,
    String password,
    String passwordConfirm,
    String cnpj,
    String cep,
    String filiais,
    String queuePreference,
    bool? termos,
    BuildContext context,
  ) {
    if (password != passwordConfirm) {
      showSnackBar(context: context, text: "Senhas não conferem");
    }
    return name.isNotEmpty &&
        email.isNotEmpty &&
        cnpj.isNotEmpty &&
        cep.isNotEmpty &&
        filiais.isNotEmpty &&
        queuePreference.isNotEmpty &&
        password.isNotEmpty &&
        password.isNotEmpty &&
        password == passwordConfirm &&
        termos == true;
  }
}
