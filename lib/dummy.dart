import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timetableapp/CurdScreen.dart';
import 'ForgotPasswordScreen.dart';
import 'SignupScreen.dart';
import 'formatters.dart';

void main() {
  runApp(Homepage());
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


class _HomepageState extends State<Homepage>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _classstudent    = TextEditingController();
  final TextEditingController _emailstudent    = TextEditingController();
  final TextEditingController _passwordstudent = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  late String studentemail;
  late String studentpassword;
  late String studentclass;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "STUDENT LOGIN SCREEN",
          style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 10,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                obscureText: true,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                  labelText: 'EMAIL'
                ),
                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                onChanged: (value) {
                 studentemail = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your class',
                  labelText: 'CLASS'
                ),
                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                onChanged: (value) {
                  studentclass = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                  labelText: 'PASSWORD'
                ),
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  onChanged: (value) {
                    studentpassword = value;
                  },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text('SIGNUP'),
                onPressed: () async {
                  Map<String,String> detail = {
                    "studentPassword"  : studentpassword,
                    "studentClass"     : studentclass,
                    "studentemail"     : studentemail,
                  };
                  try {
                    final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: studentemail, password: studentpassword).then((value) {
                      _firestore.collection('studentdetail').doc(value.user!.uid).set(detail);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("User Registered Successfully"),
                    ));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CurdScreen()));//si
                  } catch (e) {}
                  setState(() {
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}