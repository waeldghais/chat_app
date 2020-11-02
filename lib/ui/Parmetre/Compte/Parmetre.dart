import 'dart:async';
import 'dart:io';

import 'package:chat_app/localization/Cost_localization.dart';
import 'package:chat_app/model/theme.dart';
import 'package:chat_app/ui/Parmetre/Compte/parCompte.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Parmetre extends StatefulWidget {
  const Parmetre({Key key, @required this.user}) : super(key: key);
  final UserCredential user;
  @override
  _Parmetre createState() => _Parmetre(user: user);
}

class _Parmetre extends State<Parmetre> {
  _Parmetre({Key key, @required this.user});
  final UserCredential user;
  final List<Color> colorContainer = <Color>[
    Colors.purple[200],
    Colors.blue[400],
  ];
  final List<Icon> iconsList = <Icon>[
    Icon(
      Icons.brightness_4,
      color: Colors.purple[700],
      size: 24.0,
    ),
    Icon(
      Icons.account_box,
      color: Colors.blue[700],
      size: 24.0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<String> labelList = <String>['Mode Sombre', 'Compte'];
    return Scaffold(
        appBar: AppBar(
          title: Text(getTran(context, 'Paramètre'),
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Lobster')),
          centerTitle: true,
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
            itemCount: labelList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  elevation: 5,
                  color: Colors.white24,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
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
                        if (labelList[index] == 'Mode Sombre')
                          Container()
                        else
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                          ),
                      ]),
                ),
                onTap: () {
                  if (labelList[index] == 'Compte') {
                    Navigator.of(context).push(_createRouteCompte(user));
                  } else if (labelList[index] == 'Mode Sombre') {
                    final provider =
                        Provider.of<ThemeNotifier>(context, listen: false);
                    provider.toggletheme();
                  }
                },
              );
            }));
  }
}

Route _createRouteCompte(UserCredential user) {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        EditCompte(user: user),
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
