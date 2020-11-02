import 'package:chat_app/localization/Cost_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTran(context, 'Aide'),
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Lobster')),
        centerTitle: true,
      ),
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
                color: Colors.black12,
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
                        getTran(context,
                            'Quels sont les noms autorisés sur notre application'),
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(getTran(context, 'Notre application'),
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(getTran(context, 'Votre nom peut inclure'),
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(getTran(context, 'de préférence'),
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(getTran(context, 'Des titres'),
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Lobster')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: Text(getTran(context, 'Des mots'),
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
                  color: Colors.black12,
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
                      child: Text(getTran(context, 'Paramètres généraux'),
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
                          text: getTran(context, 'Cliquez sur'),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Lobster'),
                          children: <TextSpan>[
                            TextSpan(
                                text: getTran(context, 'Compte'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                )),
                            TextSpan(
                                text: getTran(
                                    context, 'pour modfier votre profile')),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 40, top: 10, right: 40),
                        child: Image.asset("asset/img/aideCmp.jpg")),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Text(getTran(context, 'Tu peut modfier'),
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
