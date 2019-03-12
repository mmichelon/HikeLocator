// This sample shows creation of a [Card] widget that shows album information
// and two actions.
import '../models/trail_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../screens/map_screen.dart';

import 'package:flutter/material.dart';

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

  TrailList(this.trails, this.userLat, this.userLon);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrailCard(),
    );
  }
}

class TrailCard extends StatelessWidget {
  TrailCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.Builder(
//      return Center(
      itemCount: trails.length,
      child: Card(
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            itemBuilder: (context, int index) {
              Object myText = json.encode(trails[index].trails);
              List<dynamic> myText2 = json.decode(myText);
            if(myText2.length > index) {
                ListTile(
                  leading: Icon(Icons.album),
                  title: Text(myText2[index]['name']),
                  subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        child: const Text('LISTEN'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ),
              }
            }
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  Card ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}