import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/services/auth.dart';
import 'package:messenger/services/data_base.dart';
import 'package:messenger/widgets/main_user_message.dart';
import 'package:messenger/widgets/other_user_message.dart';
import 'package:messenger/widgets/text_field.dart';

class ChatPage extends StatefulWidget {
  final String name, pic, email, uid;
  final bool chatOrNot;
  ChatPage({this.uid, this.email, this.pic, this.name, this.chatOrNot});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  Stream messagesStream;
  String chat;
  bool chatOrNot;

  chatExistOrNot() {
    return widget.chatOrNot;
  }

  doThis() async {
    chatOrNot = chatExistOrNot();
    setState(() {});
    messagesStream =
        await DataBase().getChats(uid: Auth.uid, gmail: widget.email);
    setState(() {});
  }

  @override
  void initState() {
    doThis();
    super.initState();
  }

  getAndSetMessage() async {
    if (controller.text != '') {
      setState(() {
        chat = controller.text;
      });

      if (chatOrNot == false) {
        Map<String, dynamic> myMap = {
          'name': widget.name,
          'email': widget.email,
          'pic': widget.pic,
          'uid': widget.uid,
        };
        Map<String, dynamic> map = {
          'name': Auth.name,
          'email': Auth.email,
          'pic': Auth.pic,
          'uid': Auth.uid,
        };
        await DataBase()
            .saveMyChatRooms(uid: Auth.uid, gmail: widget.email, map: myMap);
        await DataBase()
            .saveOtherChatRooms(uid: widget.uid, gmail: Auth.email, map: map);
      }
      var lastMessageTS = DateTime.now();
      Map<String, dynamic> myMessageInfoMap = {
        'message': chat,
        'lastMessageTS': lastMessageTS,
        'email': Auth.email,
      };
      setState(() {
        chatOrNot = true;
      });
      controller.clear();

      if (Auth.email != widget.email) {
        await DataBase().saveMyChats(
            uid: Auth.uid, gmail: widget.email, map: myMessageInfoMap);
        await DataBase().saveOtherChats(
            uid: widget.uid, gmail: Auth.email, map: myMessageInfoMap);
      } else {
        await DataBase().saveMyChats(
            uid: Auth.uid, gmail: widget.email, map: myMessageInfoMap);
      }

      setState(() {});
      messagesStream =
          await DataBase().getChats(uid: Auth.uid, gmail: widget.email);
      setState(() {});
    }
  }

  Widget messages() {
    return StreamBuilder(
      stream: messagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return ds['email'] == Auth.email
                      ? MainUserMessage(message: ds['message'])
                      : OtherUserMessage(message: ds['message']);
                },
              )
            : Center();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(widget.pic, height: 40, width: 40),
            ),
            SizedBox(width: 20),
            Text(widget.name),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: messages()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ReusableTextFormField(
              hintText: 'Type message...',
              iconData: Icons.chat,
              controller: controller,
              focusNode: focusNode,
              suffixIcon: IconButton(
                splashRadius: 25,
                icon: Icon(Icons.send, color: Colors.lightBlueAccent),
                onPressed: () {
                  getAndSetMessage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
