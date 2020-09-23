import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:translator/translator.dart';

import 'home/pagehome.dart';

class TextBtnI extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

// ignore: must_be_immutable
class _Body extends State<TextBtnI> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _passwordCo = new TextEditingController();
  TextEditingController _nom = new TextEditingController();
  TextEditingController _prenom = new TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //textfield pour nom
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white54,
                border: new Border.all(width: 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              controller: _nom,
            )),
      ),
//textfield pour Prénom
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white54,
                border: new Border.all(width: 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Prénom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              controller: _prenom,
            )),
      ),
      //textfield pour Email
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white54,
                border: new Border.all(width: 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              controller: _email,
            )),
      ),

      //textfield pour password
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white54,
                border: new Border.all(width: 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: TextField(
              obscureText: true,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              controller: _password,
            )),
      ),

//textfield pour password
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white54,
                border: new Border.all(width: 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: TextField(
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'Confirmation Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              controller: _passwordCo,
              obscureText: true,
            )),
      ),
      //Button pour la Inscription
      Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 25),
          child: RoundedLoadingButton(
            width: 100.0,
            height: 45.0,
            child: Text(
              'Inscription',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Lobster'),
            ),
            controller: _btnController,
            onPressed: () async {
              final translator = GoogleTranslator();
              try {
                if (_passwordCo.text == _password.text) {
// ignore: unused_local_variable
                  UserCredential user = (await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email.text, password: _password.text));
                  var documentReference = FirebaseFirestore.instance
                      .collection('users')
                      // ignore: unnecessary_brace_in_string_interps
                      .doc(_email.text);
                  await _firestore.runTransaction((transaction) async {
                    transaction.set(
                      documentReference,
                      {
                        'nom': _nom.text,
                        'prenom': _prenom.text,
                        'email': _email.text,
                        'image':
                            'https://firebasestorage.googleapis.com/v0/b/chat-33dec.appspot.com/o/useravatar.jpg?alt=media&token=325615b0-468f-4c37-b802-5d0619a5095b',
                        'phone': 'indisponible'
                      },
                    );
                  });
                  Timer(Duration(seconds: 3), () {
                    _btnController.success();
                  });
                  Navigator.of(context).push(_createRouteInscription(user));
                } else {
                  Timer(Duration(seconds: 1), () {
                    _btnController.reset();
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text('le mot de paase et Confirmation est inncorect'),
                  ));
                }
              } catch (e) {
                var msg = await translator.translate(e.message.toString(),
                    from: 'en', to: 'fr');
                showMyDialogErrorLog(context, "$msg");
                Timer(Duration(seconds: 3), () {
                  _btnController.reset();
                });
              }
            },
          )),
    ]);
  }
}

Route _createRouteInscription(UserCredential user) {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        HomePage(user: user),
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

Future<void> showMyDialogErrorLog(context, String error) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.blue[200],
        title: Text('Alert', style: TextStyle(color: Colors.red)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                error,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
