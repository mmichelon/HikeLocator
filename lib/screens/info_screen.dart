import '../models/trail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
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
  final List<dynamic> newTrails;
  final int curIndex;

  InfoList(this.newTrails, this.curIndex);

  Widget build(BuildContext context) {
    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      child: new Text(
          newTrails[0][curIndex]['stars'].toString()+"/5" + " Star",
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Image.network(newTrails[0][curIndex]['imgSmall']),
        Text(
          newTrails[0][curIndex]['name'].toString(),
          style: TextStyle(color: Colors.white, ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      newTrails[0][curIndex]['length'].toString() + " Miles",
//                      lesson.level,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      newTrails[0][curIndex]['summary'].toString(),
      style: TextStyle(fontSize: 18.0),
    );

    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {},
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("Save Hike", style: TextStyle(color: Colors.white)),
        ));

    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    final socialShare = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.share, color: Colors.blue),
                  Text('Twitter', style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () async {
                var response = await FlutterShareMe().shareToTwitter(
                    url: 'https://www.google.com/maps/@'+newTrails[0][curIndex]['latitude'].toString()+','+newTrails[0][curIndex]['longitude'].toString(),
                    msg: 'Check out this hike: '+newTrails[0][curIndex]['name']);
                if (response == 'success') {
                  print('navigate success');
                }
              },
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            RaisedButton(
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.share, color: Colors.green),
                  Text('WhatsApp', style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () {
                FlutterShareMe().shareToWhatsApp(
                    msg:
                    'Check out this hike: '+newTrails[0][curIndex]['name']+' at https://www.google.com/maps/@'+newTrails[0][curIndex]['latitude'].toString()+','+newTrails[0][curIndex]['longitude'].toString());
              },
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            RaisedButton(
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.share, color: Colors.blue[900]),
                  Text('Facebook', style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () {
                FlutterShareMe().shareToFacebook(
                    url: 'https://www.google.com/maps/@'+newTrails[0][curIndex]['latitude'].toString()+','+newTrails[0][curIndex]['longitude'].toString(), msg: 'Check out this hike: '+newTrails[0][curIndex]['name']);
              },
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent, socialShare],
      ),
    );
  }
}