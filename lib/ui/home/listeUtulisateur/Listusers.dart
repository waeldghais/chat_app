import 'package:chat_app/localization/Cost_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Chat/chatPage.dart';

class Listuser extends StatelessWidget {
  final String email;
  final String image;
  final bool me;
  final String nom;
  final String prenom;
  final String phone;
  final user;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Listuser(
      {Key key,
      this.email,
      this.image,
      this.me,
      this.nom,
      this.prenom,
      this.user,
      this.phone})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (email != user.user.email) {
      return Card(
        elevation: 5,
        color: Colors.white10,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(nom + ' ' + prenom,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            email,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          getTran(context, 'phone') + " : " + phone,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.supervised_user_circle),
                                  color: Colors.blue[900],
                                  tooltip: getTran(context, 'Voir profil'),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.message),
                                  color: Colors.blue[900],
                                  tooltip: getTran(context, 'Contact'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(_createRouteContact(user, email));
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
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

Route _createRouteContact(UserCredential user, String email) {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        ChatPage(
      user: user,
      email: email,
    ),
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
