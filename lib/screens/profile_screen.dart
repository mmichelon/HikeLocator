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
          height: MediaQuery.of(context).size.height * 0.30,
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
            child: ListView.builder(
              itemCount: _widgets.length,
              itemBuilder: (context, int index) {
                if(_widgets.length > index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      child: _widgets[index]
                    ),
                    onTap: () {
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoScreen(newTrails, index)),
                      );*/
                    },
                  );
                }
              },
            ))]),
      )
    );
  }

}
