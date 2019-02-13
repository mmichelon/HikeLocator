import 'package:flutter/material.dart';

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
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("HikeLocator"),
        ),
        body: new RaisedButton(
            child: Text("Click Me"),
            onPressed: () {
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


