import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServicews {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Vui lòng điền đầy đủ thông tin.";
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection("users").doc(credential.user!.uid).set({
          "name": name,
          "email": email,
          "uid": credential.user!.uid,
        });

        res = "success";
      } else {
        res = "Vui lòng điền đầy đủ thông tin.";
      }
    } catch (e) {
      print(e.toString());
      res = "Đã xảy ra lỗi: ${e.toString()}";
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Đã xảy ra lỗi không xác định.";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Vui lòng điền đầy đủ email và mật khẩu.";
      }
    } catch (e) {
      print(e.toString());
      res = "Đã xảy ra lỗi: ${e.toString()}";
    }
    return res;
  }
}
