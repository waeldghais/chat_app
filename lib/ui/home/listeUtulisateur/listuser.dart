import 'package:chat_app/localization/Cost_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bodyListuser.dart';

class Listuser extends StatefulWidget {
  const Listuser({Key key, @required this.user}) : super(key: key);
  final UserCredential user;
  @override
  _List createState() => _List(user: user);
}

class _List extends State<Listuser> {
  _List({Key key, @required this.user});
  final UserCredential user;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            getTran(context, 'User_List'),
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Lobster'),
          ),
          centerTitle: true,
        ),
        body: BodyList(user: user));
  }
}
