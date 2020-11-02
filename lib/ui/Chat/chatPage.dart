import 'package:chat_app/ui/WidgetofDrawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bodychat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key, @required this.user, @required this.email})
      : super(key: key);
  final UserCredential user;
  final String email;
  @override
  _Chat createState() => _Chat(
        user: user,
        email: email,
      );
}

class _Chat extends State<ChatPage> {
  _Chat({Key key, @required this.user, this.email});
  final UserCredential user;
  final String email;
  bool trad = false;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarChatPageTitel(context, this.email),
          actions: [
            IconButton(
              icon: Icon(Icons.blur_on),
              onPressed: () {},
            ),
          ],
        ),
        body: Bodychat(
          user: user,
          email: email,
        ));
  }
}
