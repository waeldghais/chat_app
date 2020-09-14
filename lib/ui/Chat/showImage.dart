import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
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
    Size size = MediaQuery.of(context).size;
    // My Alert Dialog for Delete Image
    Future<void> showMyDialogDeleteImage() async {
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
                    'vous avez sur de Supprimer cette image!!',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Non'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Oui'),
                onPressed: () {
                  deleteImage(context, text);
                },
              ),
            ],
          );
        },
      );
    }

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

//download Image from chat
Future downloadImage(context, text) async {
  try {
    // Saved with this method.
    var imageId = await ImageDownloader.downloadImage(text);
    if (imageId == null) {
      return;
    }

    // Below is a method of obtaining saved image information.
    // ignore: unused_local_variable
    var fileName = await ImageDownloader.findName(imageId);

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Image $fileName telecharger'),
    ));
  } on PlatformException catch (error) {
    print(error);
  }
}

//Delete Image from chat
Future deleteImage(context, text) async {
  await FirebaseFirestore.instance
      .collection('messages')
      .doc('${text.substring(68, 82)}')
      .delete();
  Navigator.of(context).pop();
}
