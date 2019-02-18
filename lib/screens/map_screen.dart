import 'package:flutter/material.dart';
import '../screens/list_screen.dart';
import '../models/trail_model.dart';
import '../screens/home_screen.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("This is where the map lies"),
        ),
        /*body:
        new RaisedButton(
            child: Text("Click Me"),
            onPressed: () {
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new ListScreen(),
              );
            }
        )*/
    );
  }
}
