import 'package:flutter/material.dart';
import '../models/trail_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../screens/list_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<MyApp> {
  int counter = 0;
  double userLat;
  double userLon;
  List<TrailModel> trails = [];
  Future<List<TrailModel>> fetchData() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    userLat = position.latitude;
    userLon = position.longitude;
    var response = await get(
        'https://www.hikingproject.com/data/get-trails?lat=$userLat&lon=$userLon&maxDistance=10&key=200419778-6a46042e219d019001dd83b13d58aa59');
    var trailModel = TrailModel.fromJson(json.decode(response.body));
    database.reference().child("counter").set({
      "counter": counter
    });
    counter++;
    trails.clear();
    for(int i = 0; i < 10; i++){
      trails.add(trailModel);
    }
    database.reference().child("counter").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> data = snapshot.value;

      print("Values from db:  ${data.values}");
    });

    return trails;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("HikeLocator")),
          body:
          new RaisedButton(
            child: Text("Find trails near me"),
            onPressed: () async {
              final trails = await fetchData();
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new ListScreen(trails, userLat, userLon)),
              );

            },
          ),


        ));
  }
}
