import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String roomId;
  final String receiverId;
  final String senderId;
  final String message;
  final Map? bikeDetail;
  final Timestamp timestamp;
  Chat({
    required this.roomId,
    required this.receiverId,
    required this.senderId,
    required this.message,
    this.bikeDetail,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'roomId': roomId,
      'receiverId': receiverId,
      'senderId': senderId,
      'message': message,
      'bikeDetail': bikeDetail,

      // INI UNTUK GENERATE TIMESTAMP BAWAAN DARI FLUTTER
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      roomId: json['roomId'] as String,
      receiverId: json['receiverId'] as String,
      senderId: json['senderId'] as String,
      message: json['message'] as String,
      bikeDetail: json['bikeDetail'] != null
          ? Map.from(json['bikeDetail'] as Map<String, dynamic>)
          : null,
      timestamp: json['timestamp'] as Timestamp,
    );
  }
}
