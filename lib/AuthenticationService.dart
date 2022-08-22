import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// registration with email and password

  Future createNewUser(String name, String email, String password) async {
    try {
      AuthResult result = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)) as AuthResult;
      FirebaseUser user = result.user;
      await FirebaseManager().createUserData(name, 'Male', 100, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

// sign with email and password

  Future loginUser(String email, String password) async {
    try {
      AuthResult result = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)) as AuthResult;
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

// signout

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

class FirebaseManager {
  createUserData(String name, String s, int i, uid) {}
}

class FirebaseUser {
  get uid => uid;
}

class AuthResult {
  FirebaseUser get user => user;
}