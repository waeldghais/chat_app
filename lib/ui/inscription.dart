import 'package:chat_app/ui/text_Btn_Inscri.dart';

import 'package:flutter/material.dart';

class PageInscription extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

// ignore: must_be_immutable
class _Body extends State<PageInscription> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inscription",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Lobster'),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height - 80,
        color: Colors.white70,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              bottom: 20,
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
                      child: Column(
                        children: [
                          TextBtnI(),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
