import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        child: ButtonTheme(
            minWidth: 80.0,
            height: 45.0,
            child: RaisedButton(
              disabledColor: Colors.white,
              onPressed: () async {
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
                        },
                      );
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(user: user)));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text('le mot de paase et Confirmation est inncorect'),
                    ));
                  }
                } catch (error) {
                  print(error);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  side: BorderSide(color: Colors.white)),
              child: const Text(
                'Inscription',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Lobster'),
              ),
            )),
      )
    ]);
  }
}
