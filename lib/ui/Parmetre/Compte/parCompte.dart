import 'dart:async';
import 'dart:io';

import 'package:chat_app/localization/Cost_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditCompte extends StatefulWidget {
  const EditCompte({Key key, @required this.user}) : super(key: key);
  final UserCredential user;
  @override
  _Compte createState() => _Compte(user: user);
}

class _Compte extends State<EditCompte> {
  _Compte({Key key, @required this.user});
  final UserCredential user;
  TextEditingController _nom = new TextEditingController();
  TextEditingController _prenom = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _copassword = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File imageFile;
  bool isLoading;
  String imageUrl;
  bool clikRang1 = false;
  bool clikRang2 = false;

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();

    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    try {
      imageFile = File(pickedFile.path);
    } catch (e) {
      print(e);
    }

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadImage();
    }
  }

// upload Image from FirebaseStorage and Send
  Future uploadImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl as String;
      setState(() {
        isLoading = false;

        FirebaseFirestore.instance
            .collection("users")
            .doc(user.user.email.toString())
            .update({'image': imageUrl}).then((_) {});
        print(true);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 15),
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Icon(
                        Icons.account_box,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTran(context, 'Compte'),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Lobster'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              getTran(context, 'Modifier et gérer'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'Lobster'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc("${widget.user.user.email}")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                //Start Update Image And first Last Name
                                GestureDetector(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              top: 40,
                                              bottom: 10,
                                              right: 10),
                                          child: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new NetworkImage(
                                                          snapshot.data
                                                              .get('image'))))),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(
                                                snapshot.data.get('nom') +
                                                    ' ' +
                                                    snapshot.data.get('prenom'),
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontFamily: 'Lobster'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 5, right: 11),
                                              child: Text(
                                                snapshot.data.get('email'),
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    fontFamily: 'Lobster'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        !clikRang1
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 24.0,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    clikRang1 = true;
                                    // ignore: invalid_use_of_protected_member
                                    (context as Element).reassemble();
                                  },
                                ),
                                clikRang1
                                    ? Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: IconButton(
                                                icon: Icon(Icons.camera_alt),
                                                onPressed: () {
                                                  getImage();

                                                  clikRang1 = false;

                                                  (context as Element)
                                                      // ignore: invalid_use_of_protected_member
                                                      .reassemble();
                                                },
                                                color: Colors.black38,
                                                iconSize: 40.0,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white12,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextField(
                                                    controller: _nom,
                                                    decoration: InputDecoration(
                                                      hintText: '   ' +
                                                          snapshot.data
                                                              .get('nom'),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Container(
                                                    width: 200,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white12,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: TextField(
                                                      controller: _prenom,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: '   ' +
                                                            snapshot.data
                                                                .get('prenom'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0,
                                                        right: 0,
                                                        top: 5),
                                                    child: RoundedLoadingButton(
                                                      width: 30.0,
                                                      height: 30.0,
                                                      child: Text(
                                                        getTran(
                                                            context, 'Edite'),
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Lobster'),
                                                      ),
                                                      controller:
                                                          _btnController,
                                                      onPressed: () async {
                                                        if (_nom.text.length >
                                                                0 &&
                                                            _prenom.text
                                                                    .length >
                                                                0) {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "users")
                                                              .doc(user
                                                                  .user.email
                                                                  .toString())
                                                              .update({
                                                            'nom': _nom.text,
                                                            'prenom':
                                                                _prenom.text
                                                          }).then((_) {});
                                                          Timer(
                                                              Duration(
                                                                  seconds: 3),
                                                              () {
                                                            _btnController
                                                                .reset();
                                                          });
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(getTran(
                                                                context,
                                                                'votre pseudo est modifié')),
                                                          ));
                                                          _nom.clear();
                                                          _prenom.clear();
                                                        } else {
                                                          Timer(
                                                              Duration(
                                                                  seconds: 3),
                                                              () {
                                                            _btnController
                                                                .reset();
                                                          });
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            content: Text(getTran(
                                                                context,
                                                                'les deux champ de pseudo doit étre remplir')),
                                                          ));
                                                        }
                                                      },
                                                    ))
                                              ],
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.red,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                clikRang1 = false;

                                                (context as Element)
                                                    // ignore: invalid_use_of_protected_member
                                                    .reassemble();
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                //End Update Image And first Last Name
                                Divider(color: Colors.white),

                                GestureDetector(
                                  child: Container(
                                      child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 35, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(getTran(context, 'phone'),
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    fontFamily: 'Lobster')),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                      snapshot.data
                                                          .get('phone'),
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'Lobster')),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      !clikRang2
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 128),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 24.0,
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )),
                                  onTap: () {
                                    clikRang2 = true;
                                    // ignore: invalid_use_of_protected_member
                                    (context as Element).reassemble();
                                  },
                                ),
                                clikRang2
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                            right: 16),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 180,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.white12,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: TextField(
                                                controller: _phone,
                                                decoration: InputDecoration(
                                                  hintText: '   ' +
                                                      snapshot.data
                                                          .get('phone'),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 0, top: 5),
                                                child: RoundedLoadingButton(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  child: Text(
                                                    getTran(context, 'Edite'),
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily: 'Lobster'),
                                                  ),
                                                  controller: _btnController,
                                                  onPressed: () async {
                                                    if (_phone.text.length ==
                                                        8) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .doc(user.user.email
                                                              .toString())
                                                          .update({
                                                        'phone': _phone.text,
                                                      }).then((_) {
                                                        Timer(
                                                            Duration(
                                                                seconds: 3),
                                                            () {
                                                          _btnController
                                                              .reset();
                                                        });
                                                      });

                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(getTran(
                                                            context,
                                                            'téléphone est modifié')),
                                                      ));
                                                      _phone.clear();
                                                    } else {
                                                      Timer(
                                                          Duration(seconds: 3),
                                                          () {
                                                        _btnController.reset();
                                                      });
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(getTran(
                                                            context,
                                                            'téléphone est incorrecte')),
                                                      ));
                                                      _phone.clear();
                                                    }
                                                  },
                                                )),
                                            GestureDetector(
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.red,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                clikRang2 = false;

                                                (context as Element)
                                                    // ignore: invalid_use_of_protected_member
                                                    .reassemble();
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          );
                        })),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, top: 10, right: 50),
                        child: Text(
                            getTran(context, 'Modifier votre mot de passe'),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Lobster')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 100, top: 10, right: 100),
                        child: Text(getTran(context, 'Mot_de_passe'),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Lobster')),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 60, top: 20, right: 60),
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: TextField(
                            controller: _password,
                            obscureText: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 45, top: 20, right: 100),
                        child: Text(getTran(context, 'conpass'),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Lobster')),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 60, top: 20, right: 60),
                        child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: TextField(
                            controller: _copassword,
                            obscureText: true,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: RoundedLoadingButton(
                            width: 30.0,
                            height: 30.0,
                            child: Text(
                              getTran(context, 'Edite'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'Lobster'),
                            ),
                            controller: _btnController,
                            onPressed: () async {
                              if (_password.text.toString() ==
                                      _copassword.text.toString() &&
                                  _password.text.length >= 6) {
                                User user = (FirebaseAuth.instance.currentUser);
                                user.updatePassword(_password.text).then((_) {
                                  Timer(Duration(seconds: 3), () {
                                    _btnController.success();
                                  });
                                  _password.clear();
                                  _copassword.clear();
                                  Timer(Duration(seconds: 5), () {
                                    _btnController.reset();
                                  });
                                });
                              } else {
                                Timer(Duration(seconds: 3), () {
                                  _btnController.error();
                                });
                                _password.clear();
                                _copassword.clear();
                                Timer(Duration(seconds: 5), () {
                                  _btnController.reset();
                                });
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
if (_copassword.text == _password.text) {
                                User user = (FirebaseAuth.instance.currentUser);
                                user.updatePassword(_password.text);

                                Timer(Duration(seconds: 3), () {
                                  _btnController.reset();
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Mot de paase modifié'),
                                ));
                                _password.clear();
                                _copassword.clear();
                              } else {
                                Timer(Duration(seconds: 3), () {
                                  _btnController.reset();
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'le mot de paase et Confirmation est inncorect'),
                                ));
                                _phone.clear();
                              }
*/
