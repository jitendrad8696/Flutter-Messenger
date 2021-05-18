import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future saveUsers(String uid, Map userInfoMap) async {
    return await _firestore.collection('users').doc(uid).set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getSearchUser(String email) async {
    return _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  Future saveMyChatRooms({String uid, gmail, Map map}) async {
    return await _firestore
        .collection('chats')
        .doc(uid)
        .collection('chatRooms')
        .doc(gmail)
        .set(map);
  }

  Future saveOtherChatRooms({String uid, gmail, Map map}) async {
    return await _firestore
        .collection('chats')
        .doc(uid)
        .collection('chatRooms')
        .doc(gmail)
        .set(map);
  }

  Future getChatRooms({String uid}) async {
    return _firestore
        .collection('chats')
        .doc(uid)
        .collection('chatRooms')
        .snapshots();
  }

  Future saveMyChats({String uid, gmail, Map map}) async {
    return await _firestore
        .collection('chats')
        .doc(uid)
        .collection('chatRooms')
        .doc(gmail)
        .collection('chat')
        .add(map);
  }

  Future saveOtherChats({String uid, gmail, Map map}) async {
    return await _firestore
        .collection('chats')
        .doc(uid)
        .collection('chatRooms')
        .doc(gmail)
        .collection('chat')
        .add(map);
  }

  getChats({String uid, gmail}) async {
    return _firestore
        .collection('chats')
        .doc(uid)
        .collection('chatRooms')
        .doc(gmail)
        .collection('chat')
        .orderBy('lastMessageTS', descending: true)
        .snapshots();
  }
}
