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


class TrailList extends StatelessWidget {
  final List<TrailModel> trails;
  final double userLat;
  final double userLon;

  TrailList(this.trails, this.userLat, this.userLon);

  Widget build(context) {
    return ListView.builder(
      itemCount: trails.length,
      itemBuilder: (context, int index) {
        Object myText = json.encode(trails[index].trails);
        List<dynamic> myText2 = json.decode(myText);
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(color:Colors.black),
            ),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(10.0),
            child: Text(myText2[index]['name']),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new MapScreen(myText2[index]['latitude'], myText2[index]['longitude'], userLat, userLon),
              ),
            );
          },
        );
      },
    );
  }
}
