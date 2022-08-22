import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurdScreen extends StatefulWidget {
  @override
  _CurdScreenState createState() => _CurdScreenState();
}

class _CurdScreenState extends State<CurdScreen> {
  late Map data;
  late String studentemail;
  late String studentname;
  late String studentclass;

  addData(){
    Map<String,String> studentdetails =  {
      'name' : studentname, 'class' : studentclass, 'email' : studentemail
    };

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('studentdetail');
    collectionReference.add(studentdetails);
  }

  fetchData() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('studentdetail');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data as Map;
      });
    });
  }

  deleteData() async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('studentdetail');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete()
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text(
                'Table',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            MaterialButton(
              onPressed: addData,
              color: Colors.amber[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text('Add Data', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: fetchData,
              color: Colors.amber[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text('Fetch Data', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: deleteData,
              color: Colors.amber[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text('Delete Data', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}