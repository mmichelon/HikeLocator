

import 'package:http/http.dart';
import 'dart:convert';
import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
void main(){
  runApp(
      MaterialApp(
      home: MyApp(),
  ),
  );
}



class HomeScreen extends StatelessWidget {
  int _counter = 0;
  void _testfunction() {
    database.reference().child("messaged").set({
      "firstname": "Charlie"
    });
    _counter++;

  }
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("HikeLocator"),
        ),
        body: new RaisedButton(
            child: Text("Click Me"),
            onPressed: () {
              _testfunction();
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new ListScreen()),
              );
            }
        )

    );
  }
}





