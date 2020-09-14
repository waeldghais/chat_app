import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Text_btnLog.dart';
import 'home/pagehome.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginPage> {
  String _email, _password;

  // ignore: unused_field
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "S'identifier",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Lobster'),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) => Center(
              child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height - 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/img/bkg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 90,
                    bottom: 100,
                    left: 25,
                    right: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22)),
                      ),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              //TEXT FiLED EMAIL
                              FiLEDEMAIL(),

                              //textfield pour password
                              FiLEDPASSWORD(),
                              //link for froget password
                              ForgetPass(),
                              // Button Connection
                              BtnConnected(),

                              //Button Text to create compte
                              Textnewct()
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }

  // Methode TEXT FiLED EMAIL
  // ignore: non_constant_identifier_names
  FiLEDEMAIL() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Container(
          decoration: new BoxDecoration(
              color: Colors.white54,
              border: new Border.all(width: 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: TextFormField(
            // ignore: missing_return
            validator: (input) {
              if (input.isEmpty) {
                return 'saisre un email svp';
              }
            },
            onSaved: (input) => _email = input,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
          )),
    );
  }

  // Methode TEXT FiLED PASSWORD
  // ignore: non_constant_identifier_names
  FiLEDPASSWORD() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Container(
          decoration: new BoxDecoration(
              color: Colors.white54,
              border: new Border.all(width: 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: TextFormField(
            // ignore: missing_return
            validator: (input) {
              if (input.isEmpty) {
                return 'saisre un password svp';
              }
            },
            onSaved: (input) => _password = input,
            obscureText: true,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
          )),
    );
  }

// Btn for Connected
  // ignore: non_constant_identifier_names
  BtnConnected() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: ButtonTheme(
          minWidth: 100.0,
          height: 45.0,
          child: RaisedButton(
            disabledColor: Colors.white,
            onPressed: singIn,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                side: BorderSide(color: Colors.white)),
            child: const Text(
              'Connecte',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Lobster'),
            ),
          )),
    );
  }

  Future<void> singIn() async {
    final formState = _formkey.currentState;

    if (formState.validate()) {
      formState.save();

      try {
        // ignore: unused_local_variable
        UserCredential user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user: user)));
      } catch (error) {
        print(error);
      }
    }
  }
}
