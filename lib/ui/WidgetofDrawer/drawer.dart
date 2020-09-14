import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CreateHeader(context, user) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('asset/img/logo.jpg'))),
      child: Stack(children: <Widget>[
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc("${user.user.email}")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Padding(
                  padding: EdgeInsets.only(top: 110, left: 10, bottom: 5),
                  child: Row(
                    children: [
                      Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      snapshot.data.get('image'))))),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          snapshot.data.get('nom') +
                              ' ' +
                              snapshot.data.get('prenom'),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Raleway'),
                        ),
                      )
                    ],
                  ));
            })
      ]));
}

// ignore: non_constant_identifier_names
Widget CreateListTile(context) {
  return Column(
    children: [
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Profil".toUpperCase(),
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway'),
              ),
            ),
          ],
        ),
        onTap: () {
          FirebaseAuth.instance.signOut().then(
              (value) => Navigator.of(context).pushReplacementNamed('/log'));
        },
      ),
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "déconnexion".toUpperCase(),
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway'),
              ),
            ),
          ],
        ),
        onTap: () {
          FirebaseAuth.instance.signOut().then(
              (value) => Navigator.of(context).pushReplacementNamed('/log'));
        },
      ),
    ],
  );
}

// ignore: non_constant_identifier_names
Widget AppBarChatPageTitel(context, email) {
  return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(email).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Row(
          children: [
            Container(
              width: 35.0,
              height: 35.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(snapshot.data.get('image')))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  snapshot.data.get('nom') + " " + snapshot.data.get('prenom'),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Lobster')),
            )
          ],
        );
      });
}
