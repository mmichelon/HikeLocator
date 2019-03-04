import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'signup_screen.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
class LogInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInScreen1();
  }
}

class LogInScreen1 extends State<LogInScreen> {
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
                    signUpButton(),
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
      child: Text("Log In"),
      onPressed: () {
        if(formkey.currentState.validate()){
          formkey.currentState.save();
        }
      },
    );
  }
  Widget signUpButton(){
    return RaisedButton(
      child: Text("don't have an account? create one here"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );

      },
    );
  }
  void fetchDataBase() {

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
