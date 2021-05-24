import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/services/auth.dart';
import 'package:messenger/services/data_base.dart';
import 'package:messenger/widgets/drawer.dart';
import 'package:messenger/widgets/list_tile.dart';
import 'package:messenger/widgets/text_field.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  Stream searchStream, userStream;

  doThis() async {
    await Auth().getCurrentUser();
    setState(() {});
    userStream = await DataBase().getChatRooms(uid: Auth.uid);
    setState(() {});
  }

  search() async {
    if (controller.text != '') {
      setState(() {});
      searchStream = await DataBase().getSearchUser(controller.text);
      setState(() {});
    }
  }

  Widget searchUserTile() {
    return StreamBuilder(
      stream: searchStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return UserListTile(
                    name: ds['name'],
                    email: ds['email'],
                    pic: ds['pic'],
                    uid: ds['uid'],
                    chatOrNot: false,
                  );
                },
              )
            : Center();
      },
    );
  }

  Widget usersTile() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return UserListTile(
                    name: ds['name'],
                    email: ds['email'],
                    pic: ds['pic'],
                    uid: ds['uid'],
                    chatOrNot: true,
                  );
                },
              )
            : Center();
      },
    );
  }

  @override
  void initState() {
    doThis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MESSENGER', style: TextStyle(fontFamily: 'Pacifico')),
      ),
      drawer: KDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ReusableTextFormField(
              hintText: 'User email',
              iconData: Icons.person,
              controller: controller,
              focusNode: focusNode,
              suffixIcon: IconButton(
                splashRadius: 25,
                icon: Icon(Icons.search, color: Colors.lightBlueAccent),
                onPressed: () {
                  search();
                  focusNode.unfocus();
                },
              ),
            ),
          ),
          searchUserTile(),
          Expanded(
            child: usersTile(),
          )
        ],
      ),
    );
  }
}
