import 'package:firebase_auth/firebase_auth.dart';
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
}
