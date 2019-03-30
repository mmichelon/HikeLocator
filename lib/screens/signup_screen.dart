import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
final FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class  SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _firstname = '';
  String _lastname = '';
  String _confirm = "";
  Future createUser() async {
    formkey.currentState.save();
    if (formkey.currentState.validate()) {
        await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((newUser) {
          print("Email: ${newUser.email}");
          Navigator.of(context).pop();
          addToDatabase(newUser.uid, _firstname, _lastname, newUser.email);
        }).catchError((e) {
          formkey.currentState.reset();
          Fluttertoast.showToast(
              msg: "Email address already exists",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
    }
  }

  addToDatabase(String uid, fname, lname, email) async{
    Firestore.instance
        .collection('users')
        .document(uid)
        .collection('profile')
        .document('profile')
        .setData({
      'First Name': fname,
      'Last Name': lname,
      'Email': email
    })
        .then((onValue) {
      print('Created it in sub collection');
    }).catchError((e) {
      print('======Error======== ' + e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        //title: Image(image:AssetImage("images/flutter1.png",),
        title: Text("HikeLocator"),
        //height: 30.0,
        //fit: BoxFit.fitHeight,),
        elevation: 0.0,

        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 210.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(500.0),
                    bottomRight: Radius.circular(500.0))),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                  child: new Form(
                key: formkey,
                child: Center(
                  child: new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      firstNameField(),
                      SizedBox(
                        width: 20.0,
                        height: 20.0,
                      ),
                      lastNameField(),
                      SizedBox(
                        width: 20.0,
                        height: 20.0,
                      ),
                      emailField(),
                      SizedBox(
                        width: 20.0,
                        height: 20.0,
                      ),
                      passwordField(),
                      SizedBox(
                        width: 20.0,
                        height: 20.0,
                      ),
                      confirmField(),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 138.0, top: 8.0),
                          child: Row(
                            children: <Widget>[
                              OutlineButton(
                                child: Text("Register"),
                                onPressed: () { createUser();
                                }
                              ),
                              SizedBox(
                                height: 18.0,
                                width: 18.0,
                              ),
                            ],
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
        RegExp exp = new RegExp(r"\w+@\w+\.\w+");
        if (!exp.hasMatch(value)) {
          formkey.currentState.reset();
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
      decoration: InputDecoration(labelText: "Password"),
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

  Widget confirmField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Confirm Password"),
      validator: (String value) {
        if (value.length < 6 ) {
          return "Password must be at least 6 characters";
        }

        if (_password != _confirm){
          return "Passwords do not match.";
        }
      },
      onSaved: (String value) {
        _confirm = value;
      },
    );
  }

  Widget firstNameField() {
    return TextFormField(

      decoration: InputDecoration(
          labelText: "First Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input cannot be blank';
        }
      },
      onSaved: (String value) {
        _firstname = value;
      },
    );
  }
  Widget lastNameField() {
    return TextFormField(

      decoration: InputDecoration(
          labelText: "Last Name"),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input cannot be blank';
        }
      },
      onSaved: (String value) {
        _lastname = value;
      },
    );
  }
}
