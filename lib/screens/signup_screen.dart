import '../authentication.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class  SignUpScreenState extends State<SignUpScreen> {
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
                                onPressed: () { createUser(context);
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

}
