import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
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

void main() {
  runApp(const SixthClass());
}

class SixthClass extends StatefulWidget {
  const SixthClass({Key? key}) : super(key: key);

  @override
  _SixthClassState createState()=> _SixthClassState();
}

class _SixthClassState extends State<SixthClass> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "SIXTH CLASS",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(value: '',)));
                //Implement logout functionality
              }),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(margin:EdgeInsets.all(10),padding: EdgeInsets.symmetric(horizontal: 15),child: Text('',style: TextStyle(color:Colors.black,fontSize:20))),
                  Container(margin:EdgeInsets.all(10),padding: EdgeInsets.all(5),child: Text('Mon',style: TextStyle(color:Colors.black,fontSize:20))),
                  Container(margin:EdgeInsets.all(10),padding: EdgeInsets.all(5),child: Text('Tue',style: TextStyle(color:Colors.black,fontSize:20))),
                  Container(margin:EdgeInsets.all(10),padding: EdgeInsets.all(5),child: Text('Wed',style: TextStyle(color:Colors.black,fontSize:20))),
                  Container(margin:EdgeInsets.all(10),padding: EdgeInsets.all(5),child: Text('Thu',style: TextStyle(color:Colors.black,fontSize:20))),
                  Container(margin:EdgeInsets.all(10),padding: EdgeInsets.all(5),child: Text('Fri',style: TextStyle(color:Colors.black,fontSize:20))),
                ],
              ),
              GridView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('9:00',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.purple[200],borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('Science',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.red[200],borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('Computer',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('Maths',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('Maths',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.yellowAccent[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Hindi',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('10:00',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.yellowAccent[200],borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('Hindi',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.green[300],borderRadius: BorderRadius.circular(5)),child: Column(children: [Text('English',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.purple[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Science',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Maths',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('11:00',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.yellowAccent[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Hindi',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.green[300],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('English',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.red[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Computer',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.purple[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Science',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('12:00',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.green[300],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('English',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Maths',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.yellowAccent[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Hindi',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.deepOrange[300],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('History',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('1:30',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.blue[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Maths',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.purple[200],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('Science',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.green[300],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('English',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                  Container(decoration: BoxDecoration(color: Colors.green[300],borderRadius: BorderRadius.circular(5)), child: Column(children: [Text('English',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))])),
                ],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:6, mainAxisSpacing:2, crossAxisSpacing:2,childAspectRatio: 0.50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}