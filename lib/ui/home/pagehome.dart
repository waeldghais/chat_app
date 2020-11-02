import 'package:chat_app/localization/Cost_localization.dart';

import 'package:chat_app/ui/PageAide/pageaide.dart';
import 'package:chat_app/ui/Parmetre/Compte/Parmetre.dart';
import 'package:chat_app/ui/Parmetre/Compte/parCompte.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../loginP.dart';
import 'listeUtulisateur/listuser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.user}) : super(key: key);
  final UserCredential user;

  @override
  _HomeState createState() => _HomeState(user: user);
}

class _HomeState extends State<HomePage> {
  _HomeState({Key key, @required this.user});
  final UserCredential user;

  final List<Color> colorContainer = <Color>[
    Colors.yellow[200],
    Colors.blue[200],
    Colors.green[200],
    Colors.red[200]
  ];
  final List<Icon> iconsList = <Icon>[
    Icon(
      Icons.chat_bubble_outline,
      color: Colors.yellow[700],
      size: 24.0,
    ),
    Icon(
      Icons.settings_applications,
      color: Colors.blue[700],
      size: 24.0,
    ),
    Icon(
      Icons.help_outline,
      color: Colors.green[700],
      size: 24.0,
    ),
    Icon(
      Icons.exit_to_app,
      color: Colors.red[700],
      size: 24.0,
    )
  ];

  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<String> labelList = <String>[
      'Commencer',
      'Paramètre',
      'Aide',
      'Déconnexion'
    ];
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Container(
                  width: size.width,
                  height: size.height,
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
                              padding: EdgeInsets.only(top: size.height * 0.15),
                              child: Container(
                                  width: 130.0,
                                  height: 130.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              snapshot.data.get('image'))))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Text(
                                snapshot.data.get('nom') +
                                    ' ' +
                                    snapshot.data.get('prenom'),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    fontFamily: 'Lobster'),
                              ),
                            ),
                          ],
                        );
                      })),
              Positioned(
                top: size.height * 0.5,
                child: SingleChildScrollView(
                  child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          itemCount: labelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                height: 70,
                                //padding: const EdgeInsets.only(top: 60),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: colorContainer[index],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: iconsList[index],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        getTran(context, '${labelList[index]}'),
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Lobster'),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (labelList[index] == 'Commencer') {
                                  Navigator.of(context)
                                      .push(_createRouteChat(user));
                                } else if (labelList[index] == 'Paramètre') {
                                  Navigator.of(context)
                                      .push(_createRouteParametre(user));
                                } else if (labelList[index] == 'Aide') {
                                  Navigator.of(context)
                                      .push(_createRouteAide());
                                } else {
                                  FirebaseAuth.instance.signOut().then(
                                      (value) => Navigator.of(context)
                                          .pushReplacement(
                                              _createRoutesignOut()));
                                }
                              },
                            );
                          })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRouteChat(UserCredential user) {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        Listuser(user: user),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
      ),
      child: child,
    ),
  );
}

Route _createRouteParametre(UserCredential user) {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        Parmetre(user: user),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
      ),
      child: child,
    ),
  );
}

Route _createRoutesignOut() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        LoginPage(),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.linearToEaseOut,
        ),
      ),
      child: child,
    ),
  );
}

Route _createRouteAide() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        AidePage(),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.linearToEaseOut,
        ),
      ),
      child: child,
    ),
  );
}
