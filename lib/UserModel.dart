import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  static const EMAIL    = 'studentemails';
  static const CLASS    = 'studentclasses';
  static const PASSWORD = 'studnetpasswords';

  String? studentemail;
  String? studentclass;
  String? studentpassword;

  String? get studentemails    => studentemail;
  String? get studentclasses   => studentclasses;
  String? get studentpasswords => studentpassword;

  UserModel.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot){
    studentemail = documentSnapshot.data()![EMAIL];
    studentclass = documentSnapshot.data()![CLASS];
    studentpassword = documentSnapshot.data()![PASSWORD];
  }
}