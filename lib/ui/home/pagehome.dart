import 'package:chat_app/ui/WidgetofDrawer/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'listuser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.user}) : super(key: key);
  final UserCredential user;

  @override
  _HomeState createState() => _HomeState(user: user);
}

class _HomeState extends State<HomePage> {
  _HomeState({Key key, @required this.user});
  final UserCredential user;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Container(
        width: 270,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              CreateHeader(context, user),
              Divider(),
              CreateListTile(context),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          "chat intimité",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Lobster'),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/img/bkg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 50,
                bottom: 200,
                left: 25,
                right: 25,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                          bottomLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22)),
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc("${widget.user.user.email}")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(
                                    width: 120.0,
                                    height: 110.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                                snapshot.data.get('image'))))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  snapshot.data.get('nom') +
                                      ' ' +
                                      snapshot.data.get('prenom'),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: ButtonTheme(
                                    minWidth: 100.0,
                                    height: 45.0,
                                    child: RaisedButton(
                                      disabledColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Listuser(user: user)));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      child: const Text(
                                        'commencer le chat',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Lobster'),
                                      ),
                                    )),
                              )
                            ],
                          );
                        })),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
