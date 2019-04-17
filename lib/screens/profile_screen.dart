import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget {
  final firstName;
  final lastName;
  final email;
  final _widgets;
  ProfileScreen(this.firstName, this.lastName, this.email, this._widgets);
  State<StatefulWidget> createState() {
    return ProfileScreenState(firstName, lastName, email, _widgets);
  }
}
class ProfileScreenState extends State <ProfileScreen> {
  var firstName;
  var lastName;
  var email;
  var _widgets;
  ProfileScreenState(this.firstName, this.lastName, this.email, this._widgets);

  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "First Name: $firstName",
          style: TextStyle(color: Colors.white, ),
        ),
        Text(
          "Last Name: $lastName",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white,),
        ),
        Text(
          "Email: $email",
          style: TextStyle(color: Colors.white, ),
        ),
      ]
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.40,
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

    final bottomContentText = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Favorite Trails",
            style: TextStyle(fontSize: 18.0),
          ),
        ]
    );

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            topContent,
            bottomContentText,
            Expanded(
            child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 2,
          // Generate 100 Widgets that display their index in the List
          children: List.generate(_widgets.length, (index) {
            return GridTile(
              child:
                _widgets[index]
            );
          }),
        ))]),
      )
    );
  }

}
