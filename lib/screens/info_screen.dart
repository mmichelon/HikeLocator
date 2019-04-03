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

  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 1,
//            value: lesson.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      child: new Text(
          newTrails[0][curIndex]['stars'].toString() + " Star",
//        "\$" + lesson.price.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        SizedBox(height: 120.0),
//        Icon(
//          Icons.directions_car,
          Image.network(newTrails[0][curIndex]['imgSmall']),

//        color: Colors.white,
//          size: 40.0,
//        ),
//        Container(
//          width: 90.0,
//          child: new Divider(color: Colors.green),
//        ),
//        SizedBox(height: 10.0),
        Text(
          newTrails[0][curIndex]['name'].toString(),
//          "Lesson Title",
//          lesson.title,
          style: TextStyle(color: Colors.white, ),
        ),
//        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      newTrails[0][curIndex]['length'].toString() + "Miles",
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

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
//  Widget build(context) {
//    return MaterialApp(
//    title: 'Flutter Demo',
//    theme: ThemeData(
//      primarySwatch: Colors.blue,
//    ),
//    home: Scaffold(
//      appBar: AppBar(
//        title: Text(newTrails[0][curIndex]['name']),
//      ),
//      body: Container(
//        child: Column(
//          children: <Widget>[
//            Image.network(newTrails[0][curIndex]['imgSmall']),
//            Text(newTrails[0][curIndex]['stars'].toString() + " Stars"),
//            Text(newTrails[0][curIndex]['summary'])
//          ],
//        ),
//      ) ,
//    ),
//
//  );
//  }
}