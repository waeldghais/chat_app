/*Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 35),
                        child: Text(
                          "Bienvenue",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "${widget.user.user.email}",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                      Container(
                          child: Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                        ),
                        child: Image.asset("asset/img/usertouser.jpg"),
                      )),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: ButtonTheme(
                            minWidth: 280.0,
                            height: 55.0,
                            child: RaisedButton(
                              disabledColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(user: user)));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  side: BorderSide(color: Colors.white)),
                              child: const Text('commencer le chat',
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.white)),
                            )),
                      )
                    ],
                  ),*/
/*drawer: Container(
        width: 270,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              CreateHeader(context, user),
              Divider(),
              CreateListTile(context),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          "chat intimité",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Lobster'),
        ),
        centerTitle: true,
      ),*/
/*Column(
                        children: [
                          //Start Route Commencer le chat
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.08,
                                top: size.height * 0.05,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[200],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.yellow[700],
                                      size: 24.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Commencer le chat',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Lobster'),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Listuser(user: user)));
                            },
                          ),
                          //End Route Commencer le chat
                          //Start Route Compte
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.08,
                                  top: size.height * 0.05),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.account_box,
                                      color: Colors.blue[700],
                                      size: 24.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Compte',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Lobster'),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 147),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Listuser(user: user)));
                            },
                          ),
                          //End Route Compte
                          //Start Route déconnexion
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.08,
                                  top: size.height * 0.05),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.red[200],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.account_box,
                                      color: Colors.red[700],
                                      size: 24.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Déconnexion',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Lobster'),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 105),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((value) =>
                                  Navigator.of(context)
                                      .pushReplacementNamed('/log'));
                            },
                          ),
                          //End Route Commencer le chat
                            ],
                      ),*/

//Start Update Email
/*          GestureDetector(
                                  child: Container(
                                      child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Email',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    fontFamily: 'Lobster')),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                  snapshot.data.get('email'),
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Lobster')),
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
                                                color: Colors.black,
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
                                    ? Container(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Row(
                                          children: [
                                            Form(
                                              key: _formkey,
                                              child: Padding(
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
                                                    controller: _email,
                                                    decoration: InputDecoration(
                                                      hintText: '   ' +
                                                          snapshot.data
                                                              .get('email'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                child: RoundedLoadingButton(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  child: Text(
                                                    '  Edite  ',
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
                                                    final formState =
                                                        _formkey.currentState;
                                                    if (_email.text.length >
                                                            0 &&
                                                        formState.validate()) {
                                                      User user = (FirebaseAuth
                                                          .instance
                                                          .currentUser);
                                                      user
                                                          .updateEmail(
                                                              _email.text)
                                                          .then((_) async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(snapshot.data
                                                                .get('email'))
                                                            .update({
                                                          'email': _email.text
                                                        });
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
                                                          content: Text(
                                                              'votre pseudo est modifié'),
                                                        ));
                                                        _email.clear();
                                                      }).catchError((error) {
                                                        print(error.toString());
                                                      });
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
                                    : Container(),*/

//End Update Email
