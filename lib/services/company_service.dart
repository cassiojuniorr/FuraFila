import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fura_fila/core/snack_bar.dart';
import 'package:fura_fila/pagesCompany/home_company.dart';

class CompanyService {
  CollectionReference db = FirebaseFirestore.instance.collection('company');

  Future<void> singUpComany({
    required String name,
    required String email,
    required String password,
    required String cnpj,
    required String cep,
    required String filiais,
    required String queuePreference,
  }) async {
    User? currentCompany = FirebaseAuth.instance.currentUser;

    if (currentCompany != null) {
      DocumentReference docRef = db.doc(currentCompany.uid);

      await docRef.set({
        'emailCompany': email,
        'nameCompany': name,
        'passwordCompany': password,
        'cep': cep,
        'cnpj': cnpj,
        'queuePreference': queuePreference,
        'filiais': filiais,
        'tags': [],
      });

      print('Document created with id: ${docRef.id}');
    } else {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    }
  }

  /* Future<void> singUpComany({
    required String name,
    required String email,
    required String password,
    required String cnpj,
    required String cep,
    required String filiais,
    required String queuePreference,
  }) async {
    print('idddddddddddddddddddddddddddddddddddddddddddddddddd, $currentCompany');
    if (currentCompany != null) {
      DocumentReference docRef = await db.add({
        'emailUser': email,
        'nameUser': name,
        'passwordUser': password,
        'cep': cep,
        'cnpj': cnpj,
        'queuePreference': queuePreference,
        'filiais': filiais,
        'tags': [""],
      });
      await FirebaseAuth.instance.currentUser!
          .updateProfile(displayName: docRef.id);
      print('id company: ${docRef.id}');
    }
  } */

  void addArray({
    required List<String> tags,
    required BuildContext context,
  }) async {
    try {
      User? currentCompany = FirebaseAuth.instance.currentUser;

      if (currentCompany == null) {
        showSnackBar(context: context, text: "Erro: usuário não autenticado");
        return;
      }
      print(
          'idddddddddddddddddddddddddddddddddddddddddddddddddd currentCompany UID: ${currentCompany.uid}');

      DocumentSnapshot docSnapshot = await db.doc(currentCompany.uid).get();
      if (!docSnapshot.exists) {
        showSnackBar(context: context, text: "Erro: Documento não encontrado!");
        return;
      }

      if (tags.isNotEmpty) {
        await db
            .doc(currentCompany.uid)
            .update({
              'tags': FieldValue.arrayUnion(tags),
            })
            .then((_) => print('tags added'))
            .catchError((error) => print("Error:  $error"));
        showSnackBar(
          context: context,
          text: 'Tags adicionadas com sucesso!!',
          isErro: false,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeCompany()),
        );
      } else {
        showSnackBar(
          context: context,
          text: "Deve-se adicionar no mínimo 1 tag",
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: "Erro: $e");
    }
  }
}
