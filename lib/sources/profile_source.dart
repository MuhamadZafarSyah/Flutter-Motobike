import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main/models/profile.dart';

class ProfileSource {
  static Future<String> editProfile(String uid, Profile profile) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);

      final updateData = <String, dynamic>{
        'name': profile.name,
        'phoneNumber': profile.phoneNumber, // konsisten: phoneNumber
        'address': profile.address,
        'gender': profile.gender,
        'profilePictureUrl': profile.profilePictureUrl,
      }..removeWhere((k, v) => v == null || (v is String && v.trim().isEmpty));

      // Upsert + merge (aman walau field belum ada)
      await docRef.set(updateData, SetOptions(merge: true));

      return 'success';
    } catch (e, st) {
      log('editProfile error: $e', stackTrace: st);
      return e.toString();
    }
  }
}
