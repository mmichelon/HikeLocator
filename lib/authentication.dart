import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
FirebaseUser mCurrentUser;
final FirebaseAuth _auth = FirebaseAuth.instance;
final formkey = new GlobalKey<FormState>();
String _email;
String _password;

String _firstname = '';
String _lastname = '';
String _confirm = "";


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



addUserToDatabase(String uid, fname, lname, email) async{
  Firestore.instance
      .collection('users')
      .document(uid)
      .setData({
    'First Name': fname,
    'Last Name': lname,
    'Email': email
  })
.catchError((e) {
    Fluttertoast.showToast(
        msg: "User creation failed: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });
}
addTrailToDatabase(trailId, trailName, trailLoc, trailUrl) async{
  var user = await getSignedInUser();
  Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('trails')
      .document(trailId)
      .setData({
    'Trail ID': trailId,
    'Trail Name': trailName,
    'Trail Location': trailLoc,
    'Image Url': trailUrl
  }).then((onValue) {
    Fluttertoast.showToast(
        msg: "trail successfully added",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  })
      .catchError((e) {
    Fluttertoast.showToast(
        msg: "Trail could not be added: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });
}
loginUser(context) async {
  formkey.currentState.save();
  if (formkey.currentState.validate()) {
    await _auth
        .signInWithEmailAndPassword(email: _email, password: _password)
        .catchError((e) {
      Fluttertoast.showToast(
          msg: "Invalid email and/or password. Please try again",
          toastLength: Toast.LENGTH_LONG,
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
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: "Update user failed: $e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
      welcomeUser();
      Navigator.of(context).pop();
    });
  }
}
welcomeUser() async{
  mCurrentUser = await _auth.currentUser();
  DocumentSnapshot result = await Firestore.instance.collection('users')
      .document(mCurrentUser.uid).get();
  String myResult = result['First Name'];
  Fluttertoast.showToast(
      msg: "Welcome $myResult!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );



}
 getSignedInUser() async {
  mCurrentUser = await FirebaseAuth.instance.currentUser();
  if(mCurrentUser == null || mCurrentUser.isAnonymous){
    return null;
  }
  else{
    return mCurrentUser;
  }
}
createUser(context) async {
  formkey.currentState.save();
  if (formkey.currentState.validate()) {

    await _auth
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((newUser) {
      Navigator.of(context).pop();
      welcomeUser();
      addUserToDatabase(newUser.uid, _firstname, _lastname, newUser.email);
    }).catchError((e) {
      formkey.currentState.reset();
      Fluttertoast.showToast(
          msg: "Email address already exists",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
}

signOutUser () async{
  await _auth.signOut();

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
