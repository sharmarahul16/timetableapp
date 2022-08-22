import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:timetableapp/AuthenticationService.dart';
import 'package:timetableapp/Classeighth.dart';
import 'package:timetableapp/Classninth.dart';
import 'package:timetableapp/Classseventh.dart';
import 'package:timetableapp/Classsixth.dart';
import 'package:timetableapp/Classtenth.dart';
import 'package:timetableapp/ForgotPasswordScreen.dart';
import 'package:timetableapp/SignupScreen.dart';
import 'package:timetableapp/formatters.dart';

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

class LoginScreen3 extends StatefulWidget {
  late final String value;
  LoginScreen3({Key? key, required this.value}) : super (key: key);

  @override
  _LoginScreenState3 createState() => _LoginScreenState3();
}

class _LoginScreenState3 extends State<LoginScreen3> {
  late List detail;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _classstudent    = TextEditingController();
  final TextEditingController _emailstudent    = TextEditingController();
  final TextEditingController _passwordstudent = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String studentemail;
  late String studentpassword;
  late String studentclass;
  late TextEditingController controller;
  bool isButtonActive = true;
  bool showSpinner = false;

  final CollectionReference studentdetails =
  FirebaseFirestore.instance.collection('studentdetails');

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  _fetchUserDetail() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('studentdetail')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        // studentemail = documentSnapshot.data()!['EMAIL'];
        print(studentemail);
      });
    }
  }
  @override
  void dispose() {
    _classstudent.dispose();
    _emailstudent.dispose();
    _passwordstudent.dispose();
    super.dispose();
  }

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
      body: ModalProgressHUD(
        key: _formKey,
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/iconing.png', height: 150, width: 100),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  initialValue: studentemail,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter, LowerCaseTextFormatter()],
                  textAlign: TextAlign.start,
                  controller: _emailstudent,
                  onChanged: (value) {
                    studentemail = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'EMAIL',
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  initialValue: studentclass,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  textAlign: TextAlign.start,
                  controller: _classstudent,
                  onChanged: (value) {
                    studentclass = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'CLASS',
                      hintText: widget.value)
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  initialValue: studentpassword,
                  obscureText: true,
                  textAlign: TextAlign.start,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
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
              TextButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
              }, child: const Text('Forgot Password',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      decoration: TextDecoration.underline
                  )),
              ),
              const SizedBox(
                height: 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onSurface: Colors.blue
                ),
                child: const Text('LogIn'),
                onPressed: () async {
                  setState(() {
                    isButtonActive = false;
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(email: studentemail, password: studentpassword);
                    if (user != null) {
                    }
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("User LoggedIn Successfully"),
                    ));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SeventhClass()));
                    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
                      if (user == null) {
                        print('User is currently signed out!');
                      } else {
                        print('User is signed in!');
                      }
                    });
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  const Text('Dont have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()));
                      // getDocs();
                      //signup screen
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
}