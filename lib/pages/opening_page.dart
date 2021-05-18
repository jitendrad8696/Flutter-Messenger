import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class OpeningPage extends StatefulWidget {
  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  bool _inAsyncCall = false;
  void onPressed() async {
    setState(() {
      _inAsyncCall = true;
    });
    await Auth().signInWithGoogle(context);
    setState(() {
      _inAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 100),
            Padding(
              padding: EdgeInsets.only(right: 12, left: 12, top: 35),
              child: Text(
                'MESSENGER',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 2,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  onPressed();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
