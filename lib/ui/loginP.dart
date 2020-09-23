import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:translator/translator.dart';
import 'Text_btnLog.dart';
import 'home/pagehome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginPage> {
  String _email, _password, errorMsg;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  // ignore: unused_field
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) => Container(
          width: size.width,
          height: size.height,
          color: Colors.white70,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 45,
                bottom: 25,
                left: 25,
                right: 25,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                          bottomLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22)),
                    ),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Text(
                                    "S'identifier",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        fontFamily: 'Lobster'),
                                  ),
                                ),

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
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Methode TEXT FiLED EMAIL
  // ignore: non_constant_identifier_names
  FiLEDEMAIL() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 100),
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
    final translator = GoogleTranslator();

    if (formState.validate()) {
      formState.save();
      try {
        // ignore: unused_local_variable
        UserCredential user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        Timer(Duration(seconds: 3), () {
          _btnController.reset();
        });
        Navigator.of(context).push(_createRoutesingIn(user));
      } catch (e) {
        var msg = await translator.translate(e.message.toString(),
            from: 'en', to: 'fr');
        showMyDialogErrorLog(context, "$msg");
        Timer(Duration(seconds: 3), () {
          _btnController.reset();
        });
      }
    }
  }

  Route _createRoutesingIn(UserCredential user) {
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
}
