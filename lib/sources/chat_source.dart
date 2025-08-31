import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main/models/chat.dart';

class ChatSource {
  static Future<void> openChatRoom(String uid, String userName) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('CS')
          .doc(uid)
          .get();
      if (doc.exists) {
        await FirebaseFirestore.instance.collection('CS').doc(uid).update({
          'newFromCS': false,
        });
        return;
      }

      await FirebaseFirestore.instance.collection('CS').doc(uid).set({
        'roomId': uid,
        'name': userName,
        // ASSIGN DEFAULT MESSAGE
        'lastMessage': 'Welcome to Motobike',
        'newFromCS': false,
        'newFromUser': true,
        // 'createdAt': FieldValue.serverTimestamp(),
      });

      // Chat firstChat = Chat(
      //   roomId: uid,
      //   receiverId: uid,
      //   senderId: 'cs',
      //   message: 'Welcome to Motobike',
      //   bikeDetail: null,
      // );

      // JIKA MENGGUNAKAN METHOD add() maka firebase akan generate id data nya secara otomatis
      await FirebaseFirestore.instance
          .collection('CS')
          .doc(uid)
          .collection('chats')
          .add({
            'roomId': uid,
            'receiverId': uid,
            'senderId': 'cs',
            'message': 'Welcome to Motobike',
            'bikeDetail': null,
            'timestamp': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> sendMessage(Chat chat, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('CS').doc(uid).update({
        'roomId': uid,
        // ASSIGN DEFAULT MESSAGE
        'lastMessage': chat.message,
        'newFromCS': true,
        'newFromUser': false,
        // 'createdAt': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('CS')
          .doc(uid)
          .collection('chats')
          .add({
            'roomId': chat.roomId,
            'receiverId': chat.receiverId,
            'senderId': chat.senderId,
            'message': chat.message,
            'bikeDetail': chat.bikeDetail,
            'timestamp': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      log(e.toString());
    }
  }
}
