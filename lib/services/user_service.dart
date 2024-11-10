import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  Future<String?> singUpUser({
    required String name,
    required String email,
    required String password,
    required UserCredential userCredential,
  }) async {
    User? user = userCredential.user;

    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDoc = firestore.collection('users').doc(user.uid);

      await userDoc.set({
        'nameUser': name,
        'emailUser': email, 
        'passwordUser': password,
      });

      print('Documento do usuário salvo com sucesso!');
      return null;
    } else {
      return 'Erro ao criar usuário';
    }
  }
}
