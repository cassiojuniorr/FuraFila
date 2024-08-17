import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompanyService {
  CollectionReference db = FirebaseFirestore.instance.collection('company');

  void singUpComany({
    required String name,
    required String email,
    required String password,
    required String cnpj,
    required String cep,
    required String filiais,
    required String queuePreference,
  }) async {
    User? company = FirebaseAuth.instance.currentUser;
    print('$company');
    if (company != null) {
      db
          .add({
            'emailUser': email,
            'nameUser': name,
            'passwordUser': password,
            'cep': cep,
            'cnpj': cnpj,
            'queuePreference': queuePreference,
            'filiais': filiais,
          })
          .then((DocumentReference doc) => print('id company: ${doc.id}'))
          .catchError((error) => print('${error}'));
    }
  }
}
