import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_screen.dart';
import 'dart:async';

final FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class LogInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInScreenState();
  }
}

class LogInScreenState extends State<LogInScreen> {
  String _email;
  String   _password;
  //google sign
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final formkey=new GlobalKey<FormState>();

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
      body:
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 110.0,
            decoration: BoxDecoration(
             //image: DecorationImage(
               //   image: AssetImage('images/monkey.gif'),
                 // fit: BoxFit.cover),
              borderRadius: BorderRadius.only
                (
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)
              ),
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
                          SizedBox(width: 20.0,height: 20.0,),
                          passwordField(),
                          new Padding(padding: EdgeInsets.all(8.0),
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
                                              onPressed:loginUser
                                          ),
                                          flex: 1,
                                        ),
                                        SizedBox(height: 18.0,width: 18.0,),

                                        SizedBox(height: 18.0,width: 18.0,),
                                        Expanded(
                                          flex: 1,
                                          child: OutlineButton(
                                              child: Image(image: AssetImage("images/google1.png"),height:28.0,fit: BoxFit.fitHeight),
                                              onPressed: ()=> googleSignin()..catchError((e){
                                                print(e);
                                              }),
                                              ),
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'New login with google?',
                                          style: TextStyle(fontFamily: 'Montserrat'),
                                        ),
                                        SizedBox(width: 5.0),
                                        InkWell(
                                          child: Text(
                                            'create new account',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline),
                                          ),
                                        )
                                      ],
                                    ),
                                    OutlineButton(
                                        child: Text("signup"),
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                                          );
                                          //Navigator.of(context).pushNamed('/signup');
                                        }),
                                  ],

                                ),

                              ),
                            ),),

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
  Future<FirebaseUser> googleSignin () async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("user is ${user.displayName}");
    return user;
      

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

  Widget loginUser(){
    return RaisedButton(
      color: Colors.blue,
      child: Text("Log In"),
      onPressed: () {
        if(formkey.currentState.validate()){
          formkey.currentState.save();
          FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
              .then((user){
            print("signed in as ${user.uid}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
            //Navigator.of(context).pushReplacementNamed('/home_screen');
          }).catchError((e){
            print(e);
          });
        }
      },
    );
  }

}
