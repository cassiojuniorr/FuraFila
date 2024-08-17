import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  void singUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    print('---------------------------------------------- $user');
    if (user != null) {
      db
          .add({'emailUser': email, 'nameUser': name, 'passwordUser': password})
          .then((DocumentReference doc) =>
              print('id user: ${doc.id}'))
          .catchError((error) => print('${error}'));
    }
  }
}
