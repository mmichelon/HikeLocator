import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";
import "login_screen.dart"; //for current user

//THINGS_TO_DO:
//I need to take in the hike's information (id # & name)
//Access the current user's username & id

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postOwner;
//  final String postMediaUrl;

  const CommentScreen({this.postId, this.postOwner});
  @override
  _CommentScreenState createState() => new _CommentScreenState(
      postId: this.postId,
      postOwner: this.postOwner);
//      postMediaUrl: this.postMediaUrl);
}

class _CommentScreenState extends State<CommentScreen> {
  final String postId;
  final String postOwner;
//  final String postMediaUrl;

  final TextEditingController _commentController = new TextEditingController();

  _CommentScreenState({this.postId, this.postOwner});

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
        .document(postId)
        .collection("comments")
        .getDocuments();
    data.documents.forEach((DocumentSnapshot doc) {
      comments.add(Comment.fromDocument(doc));
    });

    return comments;
  }

  addComment(String comment) {
    _commentController.clear();
    Firestore.instance
        .collection("hikes")
        .document(postId)
        .collection("comments")
        .add({
      "username": mCurrentUser,
      "comment": comment,
      "timestamp": DateTime.now().toString(),
//      "avatarUrl": mCurrentUser.photoUrl,
//      "userId": mCurrentUser.id
    });
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
//  final String avatarUrl;
  final String comment;
  final String timestamp;

  Comment(
      {this.username,
        this.userId,
//        this.avatarUrl,
        this.comment,
        this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot document) {
    return Comment(
      username: document['username'],
      userId: document['userId'],
      comment: document["comment"],
      timestamp: document["timestamp"],
//      avatarUrl: document["avatarUrl"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
            leading: Text(username, style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0))),
//          leading: CircleAvatar(
//            backgroundImage: NetworkImage(avatarUrl),
//          ),
        ),
        Divider(),
      ],
    );
  }
}