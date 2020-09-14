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
