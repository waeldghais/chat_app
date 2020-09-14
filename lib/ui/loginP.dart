import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Text_btnLog.dart';
import 'home/pagehome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginPage> {
  String _email, _password;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  // ignore: unused_field
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "S'identifier",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Lobster'),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) => Center(
              child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height - 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/img/bkg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 90,
                    bottom: 100,
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
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              //TEXT FiLED EMAIL
                              FiLEDEMAIL(),

                              //textfield pour password
                              FiLEDPASSWORD(),
                              //link for froget password
                              ForgetPass(),
                              // Button Connection
                              BtnConnected(),

                              //Button Text to create compte
                              Textnewct()
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }

  // Methode TEXT FiLED EMAIL
  // ignore: non_constant_identifier_names
  FiLEDEMAIL() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 45),
      child: Container(
          decoration: new BoxDecoration(
              color: Colors.white54,
              border: new Border.all(width: 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: TextFormField(
            // ignore: missing_return
            validator: (input) {
              if (input.isEmpty) {
                return 'saisre un email svp';
              }
            },
            onSaved: (input) => _email = input,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
          )),
    );
  }

  // Methode TEXT FiLED PASSWORD
  // ignore: non_constant_identifier_names
  FiLEDPASSWORD() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 35),
      child: Container(
          decoration: new BoxDecoration(
              color: Colors.white54,
              border: new Border.all(width: 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: TextFormField(
            // ignore: missing_return
            validator: (input) {
              if (input.isEmpty) {
                return 'saisre un password svp';
              }
            },
            onSaved: (input) => _password = input,
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
          )),
    );
  }

// Btn for Connected
  // ignore: non_constant_identifier_names
  BtnConnected() {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        child: RoundedLoadingButton(
          width: 100.0,
          height: 45.0,
          child: Text(
            'Connecte',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Lobster'),
          ),
          controller: _btnController,
          onPressed: singIn,
        ));
  }

  Future<void> singIn() async {
    final formState = _formkey.currentState;

    if (formState.validate()) {
      formState.save();

      try {
        // ignore: unused_local_variable
        UserCredential user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        Timer(Duration(seconds: 3), () {
          _btnController.success();
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user: user)));
      } catch (e) {
        if (e.toString() != "") {
          showMyDialogErrorLog(e.message);
          Timer(Duration(seconds: 3), () {
            _btnController.reset();
          });
        }
      }
    }
  }

  Future<void> showMyDialogErrorLog(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer Image', style: TextStyle(color: Colors.red)),
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
}
