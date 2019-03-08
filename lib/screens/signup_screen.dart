import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'dart:async';
final FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
  Future createUser()async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password)
      .then((userNew) {
        print("User created ${userNew.displayName}");
        print("Email: ${userNew.email}");
      });
      print(user.email);
    }
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
      body:ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 210.0,
            decoration: BoxDecoration(
                //image: DecorationImage(
                  //  image: AssetImage('images/google2.gif'),
                    //fit: BoxFit.contain),
                borderRadius: BorderRadius.only
                  (
                    bottomLeft: Radius.circular(500.0),
                    bottomRight: Radius.circular(500.0)
                )),
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
                          emailField(),
                          SizedBox(width: 20.0,height: 20.0,),
                          passwordField(),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 138.0,top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  OutlineButton(
                                    child: Text("Register"),
                                    onPressed: createUser,
                                  ),
                                  SizedBox(height: 18.0,width: 18.0,),


                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
        ],
      ) ,
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
        _email = value;
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
        _password = value;
      },
    );
  }
}
