import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/core/snack_bar.dart';
import 'package:fura_fila/services/company_service.dart';
import './user_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getIdUser() async {
    final User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<String?> singUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserService serviceUser = UserService();

      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      serviceUser.singUpUser(name: name, email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return 'O usuário já está cadastrda';
      }
      print('Failed with error register code: ${e.code}');
      return e.message;
    }
  }

  Future<String?> singCompany({
    required String name,
    required String email,
    required String password,
    required String cnpj,
    required String cep,
    required String filiais,
    required String queuePreference,
  }) async {
    try {
      CompanyService serviceCompany = CompanyService();

      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      serviceCompany.singUpComany(
        name: name,
        email: email,
        password: password,
        cep: cep,
        cnpj: cnpj,
        filiais: filiais,
        queuePreference: queuePreference,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return 'A empresa já está cadastrda';
      }
      print('Failed with error register code: ${e.code}');
      return e.message;
    }
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Failed with error login code: ${e.code}');
      print(e.message);
      return e;
    }
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateProfileUser(
      String namePerfil,
      String emailPerfil,
      String passwordPerfil,
      String currentPassword,
      BuildContext context) async {
    User? user = _firebaseAuth.currentUser;
    if (user == null) {
      print("Usuário não está autenticado");
      return;
    }

    print("Usuário autenticado: $user");

    try {
      // Tenta reautenticar o usuário com a senha atual
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      // Verifica a reautenticação antes de tentar atualizar
      await user.reauthenticateWithCredential(credential);
      print("Reautenticação bem-sucedida");

      // Atualiza o nome de exibição, se fornecido
      if (namePerfil.isNotEmpty) {
        await user.updateDisplayName(namePerfil);
        print("Nome atualizado para: $namePerfil");
      }

      // Atualiza o e-mail, se fornecido
      if (emailPerfil.isNotEmpty) {
        await user.verifyBeforeUpdateEmail(emailPerfil);
        print("E-mail atualizado para: $emailPerfil");
      }

      // Atualiza a senha, se fornecida
      if (passwordPerfil.isNotEmpty) {
        await user.updatePassword(passwordPerfil);
        print("Senha atualizada");
      }

      await user.reload();
      user = _firebaseAuth.currentUser;

      showSnackBar(
        context: context,
        text: "Perfil atualizado com sucesso!",
        isErro: false,
      );
    } on FirebaseAuthException catch (e) {
      // Aqui você pode verificar especificamente o erro de reautenticação
      if (e.code == "wrong-password") {
        showSnackBar(
          context: context,
          text: "Senha atual incorreta!",
          isErro: true,
        );
      } else {
        print("Erro ao atualizar perfil: ${e.code}");
        showSnackBar(
          context: context,
          text: "Erro ao atualizar perfil: ${e.message}",
          isErro: true,
        );
      }
    } catch (e) {
      print("Erro inesperado: $e");
      showSnackBar(
        context: context,
        text: "Erro inesperado ao atualizar perfil!",
        isErro: true,
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      print('saaaaaaaaaaaaaaaaaaaiiiiiiiiinnnnnnnnnnddddddddddoooooooooooo');
      showSnackBar(
        context: context,
        text: "Saida efetuada com sucesso!",
        isErro: false,
      );
    } catch (e) {
      print("Erro ao sair perfil: $e");

      showSnackBar(
        context: context,
        text: "Erro ao atualizar perfil!",
      );
    }
  }
}
