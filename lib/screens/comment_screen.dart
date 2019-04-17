import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";


class CommentScreen extends StatefulWidget {
  final List<dynamic> newTrails;
  final int curIndex;
  const CommentScreen({Key key, this.newTrails, this.curIndex}): super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HikeLocator"), backgroundColor: Colors.green[700],),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child:
          buildComments(),
        ),
        Divider(),
        ListTile(
          title: TextFormField(
            controller: _commentController,
            decoration: InputDecoration(labelText: 'Write a comment...'),
            onFieldSubmitted: addComment,
          ),
          trailing: OutlineButton(onPressed: (){addComment(_commentController.text);}, borderSide: BorderSide.none, child: Text("Post"),),
        ),

      ],
    );

  }


  Widget buildComments() {
    return FutureBuilder<List<Comment>>(
        future: getComments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data,
          );
        });
  }

  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    QuerySnapshot data = await Firestore.instance
        .collection("hikes")
        .document(widget.newTrails[0][widget.curIndex]['id'].toString())
        .collection("comments")
        .getDocuments();
    data.documents.forEach((DocumentSnapshot doc) {
      comments.add(Comment.fromDocument(doc));
    });

    return comments;
  }

  addComment(String comment) async{
    _commentController.clear();
    Firestore.instance
        .collection("hikes")
        .document(widget.newTrails[0][widget.curIndex]['id'].toString())
        .collection("comments")
        .add({
      "comment": comment,
      "timestamp": DateTime.now().toString(),
    });
  }
}

class Comment extends StatelessWidget {
  final String comment;
  final String timestamp;

  Comment(
      { this.comment,
        this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot document) {
    return Comment(
      comment: document["comment"],
      timestamp: document["timestamp"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          leading: Text("Anonymous User: ", style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
//          trailing: Text(timestamp, style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
        ),
        Divider(),
      ],
    );
  }
}