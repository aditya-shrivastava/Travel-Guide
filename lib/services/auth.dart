import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future<void> signup(String email, String password, String name) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'displayName': name,
        'email': email,
      });
    } on PlatformException catch (err) {
      var message = err;
      print(message);
    } catch (err) {
      print(err);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final data = await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .get();

      print(data);
    } catch (err) {
      print(err);
    }
  }

  Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }
}
