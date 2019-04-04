import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

SignUpScreenState signupscreen;

final FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseUser mCurrentUser;

class LogInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInScreenState();
  }
}

class LogInScreenState extends State<LogInScreen> {
  String _email;
  String _password;
  final formkey = new GlobalKey<FormState>();

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
                                                  loginUser()),
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

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email Address", hintText: 'me@example.com'),
      validator: (String value) {
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Password", hintText: 'Password'),
      validator: (String value) {
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }



  Future loginUser() async {
    formkey.currentState.save();
    if (formkey.currentState.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .catchError((e) {
        Fluttertoast.showToast(
            msg: "Invalid email and/or password. Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }).then((newUser) {
        var now = new DateTime.now();
        Firestore.instance
            .collection('users')
            .document(newUser.uid)
            .collection('userInfo')
            .document('userInfo')
            .setData({
          'Last login': now,
        })
            .then((onValue) {
          print('Created it in sub collection');
        }).catchError((e) {
          print('======Error======== ' + e);
        });
        getSignedInUser(newUser.uid);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      });


    }
  }


  getSignedInUser(String uid) async {
    mCurrentUser = await _auth.currentUser();
    DocumentSnapshot result = await Firestore.instance.collection('users')
        .document(uid).collection('profile').document('profile')
        .get();
    String myResult = result['First Name'];
    Fluttertoast.showToast(
        msg: "Welcome $myResult!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
