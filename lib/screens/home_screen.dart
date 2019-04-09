import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import '../screens/map_screen.dart';
import '../models/trail_model.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import '../authentication.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<MyApp> {
  double userLat;
  double userLon;
  double distance = 10;
  double length = 0;
  double results = 10;

  final formkey = GlobalKey<FormState>();
  List<TrailModel> trails = [];
  List<dynamic> finalTrails = [];

  Future<List<dynamic>> fetchData() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userLat = position.latitude;
    userLon = position.longitude;

    var response = await get(
        'https://www.hikingproject.com/data/get-trails?lat=$userLat&lon=$userLon&maxDistance=$distance&minLength=$length&maxResults=$results&key=200419778-6a46042e219d019001dd83b13d58aa59');
    var trailModel = TrailModel.fromJson(json.decode(response.body));

    trails.clear();
    finalTrails.clear();
    for (int i = 0; i < results; i++) {
      Object myText = json.encode(trailModel.trails);
      finalTrails.add(json.decode(myText));
    }

    return finalTrails;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(title: Text("HikeLocator"), backgroundColor: Colors.green[700],),
          body:
          Container(
              margin: EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    distanceFromUser(),
                    lengthOfTrail(),
                    numOfResults(),

                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                    ),
                    submitButton(),
                    loginButton(),
                    signupButton(),
                    logoutButton(),
                    checkUserButton(),

                  ],
                ),
              )
          )),
    );
  }

  Widget distanceFromUser() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Distance From User", hintText: 'x.x miles'),
      onSaved: (String value) {
        distance = double.parse(value);
      },
    );
  }

  Widget lengthOfTrail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Minimum Length of Trail", hintText: 'x.x miles'),
      onSaved: (String value) {
        length = double.parse(value);
      },
    );
  }

  Widget numOfResults() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Number of results", hintText: 'Top x results'),
      onSaved: (String value) {
        results = double.parse(value);
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Text("Find trails near me", style: TextStyle(color: Colors.white)),
      onPressed: () async {
        formkey.currentState.save();
        final trails = await fetchData();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapScreen(trails, userLat, userLon)),
        );
      },
    );
  }

  Widget loginButton() {
    return RaisedButton(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Text("Log In", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        );
      },
    );
  }
  Widget logoutButton() {
    return RaisedButton(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Text("Log Out", style: TextStyle(color: Colors.white)),
      onPressed: () {
        signOutUser();
      },
    );
  }
  Widget checkUserButton() {
    return RaisedButton(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Text("who's signed in?", style: TextStyle(color: Colors.white)),
      onPressed: () {
        getSignedInUser();
      },
    );
  }

  Widget signupButton() {
    return RaisedButton(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Text("Sign Up", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      },
    );
  }
}
