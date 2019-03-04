import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreen1();
  }
}

class SignUpScreen1 extends State<SignUpScreen> {
  int counter = 0;
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("HikeLocator")),
          body:
          Container(
              margin: EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    emailField(),
                    passwordField(),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                    ),
                    submitButton(),
                  ],
                ),
              )
          )
      ),
    );
  }
  Widget emailField(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email Address",
          hintText: 'me@example.com'

      ),
      validator: (String value){
        if(!value.contains('@')){
          return 'Please enter a valid email';
        }
      },
      onSaved:(String value){
        email = value;
      },
    );
  }

  Widget passwordField(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: 'Password'
      ),
      validator: (String value){
        if(value.length < 4){
          return "Password must be at least 4 characters";
        }
      },
      onSaved:(String value){
        password = value;
      },
    );
  }
  Widget submitButton(){
    return RaisedButton(
      color: Colors.blue,
      child: Text("Sign Up"),
      onPressed: () {
        if(formkey.currentState.validate()){
          formkey.currentState.save();
        }
      },
    );
  }
  void insertToDataBase() {

    database.reference().child("counter").set({
      "counter": counter
    });
    counter++;
    database.reference().child("counter").once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> data = snapshot.value;

      print("Values from db:  ${data.values}");
    });

  }
}
