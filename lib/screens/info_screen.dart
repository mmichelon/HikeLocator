import '../models/trail_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../screens/map_screen.dart';
class InfoScreen extends StatelessWidget {
//  final List<TrailModel> trails;
  final List<dynamic> newTrails[][];
//  final userLat;
//  final userLon;
  InfoScreen(this.newTrails);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      body: InfoList(newTrails),
    );
  }
}

class InfoList extends StatelessWidget{
//  final List<TrailModel> trails;
  final List<dynamic> newTrails;

  InfoList(this.newTrails);

  Widget build(context) {
    return Scaffold(
    );
  }
}