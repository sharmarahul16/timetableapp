import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timetableapp/LoginScreen2.dart';
import 'package:timetableapp/dummy.dart';
import '../LoginScreen.dart';
import '../formatters.dart';
import 'Classeighth.dart';
import 'Classninth.dart';
import 'Classseventh.dart';
import 'Classsixth.dart';
import 'Classtenth.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentname     = TextEditingController();
  final TextEditingController _studentclass    = TextEditingController();
  final TextEditingController _studentemail    = TextEditingController();
  final TextEditingController _studentpassword = TextEditingController();
  final TextEditingController _confimpassword  = TextEditingController();
  final _auth      = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final CollectionReference studentdetails =
  FirebaseFirestore.instance.collection('studentdetails');

  late String studentname;
  late String studentclass;
  late String studentemail;
  late String studentpassword;
  late String studentconfirmpass;
  late TextEditingController controller;
  late String selectClass = "";
  late User loggedInUser;
  bool isButtonActive     = true;
  bool showSpinner        = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    _studentname     .dispose();
    _studentclass    .dispose();
    _studentemail    .dispose();
    _studentpassword .dispose();
    _confimpassword  .dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        if (kDebugMode) {
          print(loggedInUser.email);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "SIGNUP STUDENT",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 10,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        key: _formKey,
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/iconing.png',height: 150, width: 100),
              const SizedBox(
                height: 30,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter, UpperCaseTextFormatter()],
                  textAlign: TextAlign.start,
                  controller: _studentname,
                  onChanged: (value) {
                    studentname = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'NAME',
                      hintText: 'Enter your name')),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter, FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.start,
                  controller: _studentclass,
                  onChanged: (value) {
                    studentclass = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'CLASS',
                      hintText: 'Enter your class')
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter, LowerCaseTextFormatter()],
                  textAlign: TextAlign.start,
                  controller: _studentemail,
                  onChanged: (value) {
                    studentemail = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'EMAIL',
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.start,
                  controller: _studentpassword,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  onChanged: (value) {
                    studentpassword = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'PASSWORD',
                      hintText: 'Enter your Password')),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.start,
                  controller: _confimpassword,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  onChanged: (value) {
                    studentconfirmpass = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'CONFIRM',
                      hintText: 'Confirm your Password')),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onSurface: Colors.blue
                  ),
                  child: const Text('SIGNUP'),
                  onPressed: () async {
                    // var route = new MaterialPageRoute(
                    //   builder: (BuildContext context) => new LoginScreen(value: _studentclass.text),
                    // );
                    // Navigator.of(context).push(route);
                    // setState(() {
                    //   isButtonActive = false;
                    //   showSpinner = true;
                    // });
                    Map<String,String> detail = {
                      "studentName"  : studentname,
                      "studentClass" : studentclass,
                      "studentemail" : studentemail,
                    };
                    if (studentpassword == studentconfirmpass) {
                      try {
                        final newUser = await _auth.createUserWithEmailAndPassword(email: studentemail, password: studentpassword).then((value) {
                          _firestore.collection('studentdetail').doc(value.user!.uid).set(detail);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("User Registered Successfully"),
                        ));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));//si
                      } catch (e) {}
                      setState(() {
                        showSpinner = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Incorrect Password"),
                      ));
                    }
                  }
              ),
              Row(
                children: <Widget>[
                  const Text('Already have account?'),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen2(value: '',)));//signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void FunctionMessage() {
    int value = int.parse(studentclass);
    if (value == 6) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SixthClass()));
    } else if (value == 7) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SeventhClass()));
    } else if (value == 8) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const EighthClass()));
    } else if (value == 9) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const NinthClass()));
    } else if (value == 10) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const TenthClass()));
    } else {
      ("Please enter valid class");
    }
  }
}


class NextPage extends StatefulWidget {
  final String value;
  NextPage({Key? key, required this.value}) : super (key: key);
  @override
  _NextPageState createState()=> _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context ) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Next Page"),
      ),
      body: new Text("${widget.value}"),
    );
  }
}