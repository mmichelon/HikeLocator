import 'package:flutter/material.dart';
import '../models/trail_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../screens/list_screen.dart';
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<MyApp> {
  List<TrailModel> trails = [];
  Future<List<TrailModel>> fetchData() async {
    var response = await get(
        'https://www.hikingproject.com/data/get-trails?lat=39.733694&lon=-121.854771&maxDistance=10&key=200419778-6a46042e219d019001dd83b13d58aa59');

    var trailModel = TrailModel.fromJson(json.decode(response.body));
    trails.clear();
    for(int i = 0; i < 10; i++){
      trails.add(trailModel);
    }

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
                new MaterialPageRoute(builder: (context) => new ListScreen(trails)),
              );
            },
          ),
        ));
  }
}
