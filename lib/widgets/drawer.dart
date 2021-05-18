import 'package:flutter/material.dart';
import 'package:messenger/pages/opening_page.dart';
import 'package:messenger/services/auth.dart';

class KDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(Auth.pic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    Auth.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
                Text(
                  Auth.email,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(
            height: 0,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text('Log out'),
            onTap: () async {
              await Auth().signOut().then(
                (value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpeningPage(),
                    ),
                  );
                },
              );
            },
          ),
          Divider(
            height: 0,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
