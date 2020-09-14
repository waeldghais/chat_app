import 'package:chat_app/ui/Chat/chatPage.dart';

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/img/bkg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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

class Listuser extends StatelessWidget {
  final String email;
  final String image;
  final bool me;
  final String nom;
  final String prenom;
  final user;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Listuser(
      {Key key,
      this.email,
      this.image,
      this.me,
      this.nom,
      this.prenom,
      this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (email != user.user.email) {
      return Card(
        elevation: 5,
        color: Colors.black12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(19),
                  child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(image)))),
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(nom + ' ' + prenom,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          email,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.supervised_user_circle),
                                  color: Colors.blue[900],
                                  tooltip: 'Voir profil',
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.message),
                                  color: Colors.blue[900],
                                  tooltip: 'Contact',
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ChatPage(
                                                  user: user,
                                                  email: email,
                                                )));
                                  }),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
