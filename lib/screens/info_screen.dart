import '../models/trail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'comment_screen.dart';
import 'dart:convert';
import '../screens/map_screen.dart';
import '../authentication.dart';


class InfoScreen extends StatelessWidget {
  final List<dynamic> newTrails;
  final int curIndex;
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
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      newTrails[0][curIndex]['length'].toString() + " Miles",
//                      lesson.level,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 2, child: coursePrice)
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
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width/3,
        child: RaisedButton(
          onPressed: () => {
            addTrailToDatabase( newTrails[0][curIndex]['id'].toString(),  newTrails[0][curIndex]['name'].toString()
                ,  newTrails[0][curIndex]['location'].toString())

          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("Save Hike", style: TextStyle(color: Colors.white)),
        ));

    final commentButton = Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width/3,
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommentScreen(newTrails: newTrails, curIndex: curIndex)),
            );
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("Comments", style: TextStyle(color: Colors.white)),
        ));

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
            Center( child: Row(
                children: <Widget>[
                  readButton,
                  commentButton,
                ]),),
          ],
        ),
      ),
    );

    final socialShare = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
      child: Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.share, color: Color.fromRGBO(58, 66, 86, 1.0)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            Padding(padding: EdgeInsets.all(1.0)),
            RaisedButton(
              color: Colors.green,
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.share, color: Color.fromRGBO(58, 66, 86, 1.0)),
                  Text('WhatsApp', style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () {
                FlutterShareMe().shareToWhatsApp(
                    msg:
                    'Check out this hike: '+newTrails[0][curIndex]['name']+' at https://www.google.com/maps/@'+newTrails[0][curIndex]['latitude'].toString()+','+newTrails[0][curIndex]['longitude'].toString());
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
            Padding(padding: EdgeInsets.all(1.0)),
            RaisedButton(
              color: Colors.blue[900],
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.share, color: Color.fromRGBO(58, 66, 86, 1.0)),
                  Text('Facebook', style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () {
                FlutterShareMe().shareToFacebook(
                    url: 'https://www.google.com/maps/@'+newTrails[0][curIndex]['latitude'].toString()+','+newTrails[0][curIndex]['longitude'].toString(), msg: 'Check out this hike: '+newTrails[0][curIndex]['name']);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[topContent, bottomContent, socialShare],
      ),
    );
  }
}
