import 'package:flutter/material.dart';

import 'inscription.dart';

class ForgetPass extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(children: [
      //textfield pour Email

      //Button Text if forget password
      TextForgetPass(),
      //Button pour la connection
    ]);
  }
}

class TextForgetPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 150, top: 10),
        child: InkWell(
          // When the user taps the button, show a snackbar.
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Tap'),
            ));
          },
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Text('Mot de Passe Oublié?',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
          ),
        ));
  }
}

class Textnewct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 30, right: 20),
        child: InkWell(
          // When the user taps the button, show a snackbar.
          onTap: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Text("vous n'avez pas de compte? Créer un nouveau",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
          ),
        ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        PageInscription(),
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
