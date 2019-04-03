import '../models/trail_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../screens/map_screen.dart';
class InfoScreen extends StatelessWidget {
//  final List<TrailModel> trails;
  final List<dynamic> newTrails;
  final int curIndex;
//  final userLat;
//  final userLon;
  InfoScreen(this.newTrails, this.curIndex);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      body: InfoList(newTrails, curIndex),
    );
  }
}

class InfoList extends StatelessWidget{
//  final List<TrailModel> trails;
  final List<dynamic> newTrails;
  final int curIndex;

  InfoList(this.newTrails, this.curIndex);

  Widget build(context) {   return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text(newTrails[0][curIndex]['name']),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network(newTrails[0][curIndex]['imgSmall']),
            Text(newTrails[0][curIndex]['stars'].toString() + " Stars"),
          ],
        ),
      ) ,
    ),

  );
  }
}