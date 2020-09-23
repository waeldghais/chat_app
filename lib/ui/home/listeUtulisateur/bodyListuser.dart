import 'package:chat_app/ui/home/listeUtulisateur/Listusers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BodyList extends StatefulWidget {
  const BodyList({Key key, @required this.user}) : super(key: key);
  final UserCredential user;
  @override
  _List createState() => _List(user: user);
}

class _List extends State<BodyList> {
  _List({Key key, @required this.user});
  final UserCredential user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //list of users
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //get all list of users
                stream: _firestore
                    .collection('users')
                    // ignore: unrelated_type_equality_checks
                    // .where("email", isEqualTo: widget.user.user.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  List<DocumentSnapshot> docs = snapshot.data.docs;

                  List<Widget> messeges = docs
                      .map((doc) => Listuser(
                          email: doc.get('email'),
                          image: doc.get('image'),
                          me: widget.user.user.email == doc.data().values.first,
                          nom: doc.get('nom'),
                          prenom: doc.get('prenom'),
                          phone: doc.get('phone'),
                          user: user))
                      .toList();
                  return ListView(
                    shrinkWrap: true,
                    //reverse: true,
                    //scrollDirection: Axis.vertical,
                    //controller: scrollController,
                    children: <Widget>[
                      ...messeges,
                    ],
                  );
                },
              ),
            ),
            //and of List
          ],
        )));
  }
}
