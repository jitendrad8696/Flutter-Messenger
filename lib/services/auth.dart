import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger/pages/chat_room_page.dart';
import 'package:messenger/services/data_base.dart';

class Auth {
  static String email, name, pic, uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _signIn = GoogleSignIn();

  Future signOut() async {
    try {
      await _signIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future getCurrentUser() async {
    try {
      User user = _auth.currentUser;
      email = user.email;
      name = user.displayName;
      pic = user.photoURL;
      uid = user.uid;
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount account = await _signIn.signIn();
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User user = userCredential.user;
      if (userCredential != null) {
        email = user.email;
        name = user.displayName;
        pic = user.photoURL;
        uid = user.uid;
        Map<String, dynamic> userInfoMap = {
          'name': name,
          'email': email,
          "pic": pic,
          "uid": uid,
        };
        await DataBase().saveUsers(uid, userInfoMap);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomPage(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
