import 'dart:async';
import 'dart:io';

import 'package:chat_app/localization/Cost_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../model/Message.dart';

class Bodychat extends StatefulWidget {
  const Bodychat({Key key, @required this.user, this.email}) : super(key: key);
  final UserCredential user;
  final String email;

  @override
  _Body createState() => _Body(
        user: user,
        email: email,
      );
}

class _Body extends State<Bodychat> {
  _Body({Key key, @required this.user, this.email});
  final UserCredential user;
  final String email;
  ScrollController scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  TextEditingController textTra = TextEditingController();

  File imageFile;
  bool isLoading;
  String imageUrl;
  bool pressGal = false;
  bool pressCam = false;
  bool pressTran = false;
  bool getOption = true;
  var _langText = ["fr", "en", "ar", "es"];
  var _selected = "fr";
  var _tradTextTo = ["fr", "en", "ar", "es"];
  var _selectedTo = "en";
//Send  Simpel Message
  Future<void> sendMessage() async {
    if (messageController.text.length > 0) {
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          // ignore: unnecessary_brace_in_string_interps
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      await _firestore.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'to': email,
            'content': messageController.text,
            'from': widget.user.user.email,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'type': 0,
            'isVideo': false
          },
        );
      });
      messageController.clear();
      scrollController.animateTo(
        0.0,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

//go to gallery and upload image
  Future getImage(int type) async {
    ImagePicker imagePicker = ImagePicker();

    PickedFile pickedFile;
    if (type == 1) {
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    } else if (type == 0) {
      pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    } else if (type == 2) {
      pickedFile = await imagePicker.getVideo(source: ImageSource.camera);
    } else {
      pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);
    }

    try {
      imageFile = File(pickedFile.path);
    } catch (e) {
      print(e);
    }

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadImage(type);
    }
  }

// upload Image from FirebaseStorage and Send
  Future uploadImage(int type) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl as String;
      setState(() {
        isLoading = false;
        if (type == 2 || type == 3) {
          onSendImage(imageUrl, 1, true);
          print(true);
        } else {
          onSendImage(imageUrl, 1, false);
          print(false);
        }
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

// Send message Image
  void onSendImage(String content, int type, bool isVideo) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          // ignore: unnecessary_brace_in_string_interps
          .doc('${content.substring(68, 82)}');

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'to': email,
            'from': widget.user.user.email,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type,
            'isVideo': isVideo
          },
        );
      }).catchError((e) => print(e.toString()));
      scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send',
          backgroundColor: Colors.black,
          textColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //list of chat Dusx (Simpel Message && Image)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //get all list of chat orderBy timestamp
                stream: _firestore
                    .collection('messages')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  List<DocumentSnapshot> docs = snapshot.data.docs;

                  List<Widget> messeges = docs
                      .map((doc) => Message(
                          from: doc.get('from'),
                          text: doc.get('content'),
                          me: widget.user.user.email == doc.get('from'),
                          type: doc.get('type'),
                          to: email == doc.get('to'),
                          notMe: email == doc.get('from'),
                          toMe: widget.user.user.email == doc.get('to'),
                          isVideo: doc.get('isVideo')))
                      .toList();
                  return ListView(
                    shrinkWrap: true,
                    controller: scrollController,
                    children: <Widget>[
                      ...messeges,
                    ],
                  );
                },
              ),
            ),
            //and of List
            //camera
            pressCam
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    height: 35,
                    width: 144,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.broken_image),
                          onPressed: () {
                            //camera
                            getImage(0);
                            pressCam = false;
                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          },
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: Icon(Icons.videocam),
                          onPressed: () {
                            //camera
                            getImage(2);
                            pressCam = false;
                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          },
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            pressCam = false;
                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          },
                          color: Colors.red,
                        ),
                      ],
                    ))
                : Container(),
            //Gallery
            pressGal
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    height: 35,
                    width: 144,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {
                            //gallery
                            getImage(1);
                            pressGal = false;
                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          },
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: Icon(Icons.video_library),
                          onPressed: () {
                            //camera
                            getImage(3);
                            pressGal = false;
                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          },
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            pressGal = false;

                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          },
                          color: Colors.red,
                        ),
                      ],
                    ))
                : Container(),
            //Menu option

            pressTran
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    height: 220,
                    width: size.width - 50,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Row(
                            children: [
                              Text(
                                getTran(context, 'tra'),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Lobster'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: IconButton(
                                  icon: Icon(Icons.clear),
                                  iconSize: 25,
                                  onPressed: () {
                                    pressTran = false;
                                    // ignore: invalid_use_of_protected_member
                                    (context as Element).reassemble();
                                  },
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                labelText: getTran(context, 'traMot')),
                            controller: textTra,
                          ),
                        ),
                        //lena
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                items:
                                    _langText.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(
                                      dropDownStringItem,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newValeuSelected) {
                                  setState(() {
                                    this._selected = newValeuSelected;
                                  });
                                },
                                value: _selected,
                              ),
                              IconButton(
                                icon: Icon(Icons.redo),
                                iconSize: 25,
                                onPressed: () {},
                                color: Colors.blue,
                              ),
                              DropdownButton<String>(
                                items: _tradTextTo
                                    .map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(
                                      dropDownStringItem,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String newValeuSelected) {
                                  setState(() {
                                    this._selectedTo = newValeuSelected;
                                  });
                                },
                                value: _selectedTo,
                              ),
                            ],
                          ),
                        ),

                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              color: Colors.blue,
                              onPressed: () async {
                                final translator = GoogleTranslator();
                                pressTran = false;
                                // ignore: invalid_use_of_protected_member
                                (context as Element).reassemble();
                                var msg = await translator.translate(
                                    textTra.text,
                                    from: _selected,
                                    to: _selectedTo);
                                textTra.clear();
                                showMyDialogErrorLog(context, "$msg");
                              },
                            ),
                            FlatButton(
                              child: Text('Cancel'),
                              color: Colors.blue,
                              onPressed: () {
                                pressTran = false;
                                // ignore: invalid_use_of_protected_member
                                (context as Element).reassemble();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: getOption
                    ? Container(
                        height: 45,
                        decoration: new BoxDecoration(
                          border: new Border.all(width: 0.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              iconSize: 25,
                              onPressed: () {
                                //gallery
                                getOption = false;
                                pressCam = false;
                                pressGal = false;
                                // ignore: invalid_use_of_protected_member
                                (context as Element).reassemble();
                              },
                              color: Colors.blue,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: TextField(
                                  style: TextStyle(color: Colors.white12),
                                  onSubmitted: (value) => sendMessage(),
                                  decoration: InputDecoration(
                                    hintText: 'Aa',
                                    //prefixIcon:
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                  controller: messageController,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              color: Colors.blue,
                              onPressed: sendMessage,
                            )
                          ],
                        ))
                    : Container(
                        height: 45,
                        decoration: new BoxDecoration(
                          border: new Border.all(width: 0.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: IconButton(
                                icon: Icon(Icons.apps),
                                onPressed: () {
                                  //gallery
                                  pressGal = true;
                                  pressCam = false;
                                  pressTran = false;
                                  // ignore: invalid_use_of_protected_member
                                  (context as Element).reassemble();
                                },
                                color: Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  //Camera
                                  pressCam = true;
                                  pressGal = false;
                                  pressTran = false;
                                  // ignore: invalid_use_of_protected_member
                                  (context as Element).reassemble();
                                },
                                color: Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: IconButton(
                                icon: Icon(Icons.g_translate),
                                onPressed: () {
                                  pressTran = true;
                                  pressGal = false;
                                  pressCam = false;
                                  // ignore: invalid_use_of_protected_member
                                  (context as Element).reassemble();
                                },
                                color: Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                iconSize: 30,
                                onPressed: () {
                                  getOption = true;

                                  // ignore: invalid_use_of_protected_member
                                  (context as Element).reassemble();
                                },
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        )))
          ],
        )));
  }

  Future<void> showMyDialogErrorLog(context, String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(getTran(context, 'tra'),
              style: TextStyle(color: Colors.red)),
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
