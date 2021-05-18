import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/pages/chat_room_page.dart';
import 'package:messenger/pages/opening_page.dart';
import 'package:messenger/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Colors.lightBlueAccent),
      home: FutureBuilder(
        future: Auth().getCurrentUser(),
        builder: (context, snapshot) {
          return snapshot.hasData ? ChatRoomPage() : OpeningPage();
        },
      ),
    );
  }
}
