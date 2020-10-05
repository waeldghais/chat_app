import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

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
