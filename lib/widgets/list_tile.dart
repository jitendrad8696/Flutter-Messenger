import 'package:flutter/material.dart';
import 'package:messenger/pages/chat_page.dart';

class UserListTile extends StatelessWidget {
  final String name, pic, email, uid;
  final bool chatOrNot;
  UserListTile({this.name, this.pic, this.email, this.uid, this.chatOrNot});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 0,
          thickness: 2,
        ),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.network(pic, height: 45, width: 45),
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  name: name,
                  email: email,
                  uid: uid,
                  pic: pic,
                  chatOrNot: chatOrNot,
                ),
              ),
            );
          },
        ),
        Divider(
          height: 0,
          thickness: 2,
        ),
      ],
    );
  }
}
