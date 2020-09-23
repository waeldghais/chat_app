import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;
  @override
  _Image createState() => _Image(
        text: text,
      );
}

class _Image extends State<ShowImage> {
  _Image({Key key, this.text});

  final String text;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: PhotoView(
          minScale: 0.12,
          maxScale: 0.9,
          imageProvider: NetworkImage(text),
          backgroundDecoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
