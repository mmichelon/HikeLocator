import '../models/trail_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../screens/map_screen.dart';
class ListScreen extends StatelessWidget {
  final List<TrailModel> trails;
  final userLat;
  final userLon;
  ListScreen(this.trails, this.userLat, this.userLon);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Here are your trails"),
      ),
      body: TrailList(trails, userLat, userLon),
    );
  }
}

class TrailList extends StatelessWidget{
  final List<TrailModel> trails;
  final double userLat;
  final double userLon;

  final leftSection = new Container(
    child: new CircleAvatar(
//      backgroundImage: new NetworkImage(url),
      backgroundColor: Colors.lightGreen,
      radius: 24.0,
    ),
  );
  final middleSection = new Expanded(
    child: new Container(
      padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text("Name",
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),),
          new Text("Hi whatsp?", style:
          new TextStyle(color: Colors.grey),),
        ],
      ),
    ),
  );
  final rightSection = new Container(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text("9:50",
          style: new TextStyle(
              color: Colors.lightGreen,
              fontSize: 12.0),),
        new CircleAvatar(
          backgroundColor: Colors.lightGreen,
          radius: 10.0,
          child: new Text("2",
            style: new TextStyle(color: Colors.white,
                fontSize: 12.0),),
        )
      ],
    ),
  );

  TrailList(this.trails, this.userLat, this.userLon);

  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new Container(
//        child: new Row(
//          children: <Widget>[
//            leftSection,
//            middleSection,
//            rightSection
//          ],
//        ),
//      ),
//    );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
        backgroundColor: Colors.red,
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Please Login'),
              new Row(
                children: <Widget>[
                  new Text('Username'),
                  /*this will give an error because TextField is infinite, you can type
                  and type, it doesn't know where to stop and confuse Flutter but our
                  screen width is limited o to solve this we use 'Expanded' widget
                  controller is like an Android Cursor and we use it with TextField*/
                  //new TextField(controller: _user,)

                  new Expanded(child: new TextField(controller: _user,))
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text('Password'),
                  //obscureText changes text to dots for password fields
                  new Expanded(child: new TextField(controller: _pass, obscureText: true,))
                ],
              ),

              new Padding(
                padding: new EdgeInsets.all(32.0),
                //onPressed will show login with the username typed on terminal
                child: new RaisedButton(onPressed: () => print('Login ${_user.text}'), child: new Text('Click me'),),
              )

            ],
          ),
        ),
      ),
    );
  }
}