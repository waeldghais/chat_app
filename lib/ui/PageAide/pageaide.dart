import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Page d'aide",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Lobster')),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[200],
      body: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Container(
              width: size.width - 60,
              height: size.height * 0.41,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60, top: 20),
                    child: Text(
                        "Quels sont les noms autorisés sur notre application ?",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                        "Notre application est une communauté dans laquelle chaque utilisateur emploie le nom dont il se sert au quotidien. De cette façon, toute personne peut connaître l’identité de son interlocuteur.",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                        "Votre nom peut inclure tout les éléments ( symboles, des chiffres ...) ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                        "Mais de préférence ne peut pas inclure dans votre nom : ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                        "- Des titres de quelque nature que ce soit (par exemple, professionnel, religieux)  ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: Text(
                        "- Des mots ou des expressions au lieu d’un nom  ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: size.height * 0.46,
              bottom: 15,
              left: 15,
              right: 15,
              child: Container(
                width: size.width - 60,
                height: size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 20),
                      child: Text(
                          "Comment modifier les Paramètres généraux du votre profil ?",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              fontFamily: 'Lobster')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Cliquez sur ',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Lobster'),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Compte ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                )),
                            TextSpan(
                                text:
                                    "dans la page d'accueil, pour modfier votre profile"),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40, top: 10),
                        child: Image.asset("asset/img/aideCmp.jpg")),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                          "Tu peut modfier votre Image, Nom, Prénom, Email, Mot de passe, .... ",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Lobster')),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
