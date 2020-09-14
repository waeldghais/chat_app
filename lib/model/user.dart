import 'package:firebase_database/firebase_database.dart';

class Usertodatabase {
  addNewUser(user, context) {
    FirebaseDatabase.instance
        .reference()
        .child("users")
        .push()
        .set({'email': user.email, 'uid': user.uid}).catchError((e) {
      print(e);
    });
  }
}
