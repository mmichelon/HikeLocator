
import '../authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;




class LogInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInScreenState();
  }
}

class LogInScreenState extends State<LogInScreen> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        //title: Image(image:AssetImage("images/flutter1.png",),height: 30.0,fit: BoxFit.fitHeight,),
        title: Text("Image will go here"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 110.0,
            decoration: BoxDecoration(
              //image: DecorationImage(
              //   image: AssetImage('images/monkey.gif'),
              // fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                  child: Form(
                    key: formkey,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          emailField(),
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                          ),
                          passwordField(),
                          new Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: OutlineButton(
                                              child: Text("Login "),
                                              onPressed: () =>
                                                  loginUser(context)),
                                          flex: 1,
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                          width: 18.0,
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                          width: 18.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        SizedBox(width: 5.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }



}
