import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new HomeScreen(),
    );
  }
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

class ListScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("List is where the list lies"),
        ),
        body: new RaisedButton(
            child: Text("Click Me"),
            onPressed: () {
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new MapScreen()),
              );
            }
        )
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("List is where the map lies"),
        ),
        body: new RaisedButton(
          child: Text("Click Me"),
            onPressed: () {
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new HomeScreen()),
              );
            }
        )
    );
  }
}


