import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection('users');

  void singUpUser({
    required String name,
    required String email,
    required String password,
  }) {
    var newUser = {
      'emailUser': email,
      'nameUser': name,
      'passwordUser': password
    };
    db.add(newUser);
  }
}
