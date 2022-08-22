import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetableapp/dummy.dart';
import 'LoginScreen2.dart';
import 'SignupScreen.dart';
import 'SignupScreen2.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? Key }) : super(key: Key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetosignupohome();
  }

  _navigatetosignupohome()async {
    FirebaseApp app = await Firebase.initializeApp();
    await Future.delayed(Duration(milliseconds: 1500), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen2(value: '',)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Image.asset('assets/iconing.png', height: 200, width: 200),
        ),
      ),
    );
  }
}