import 'package:d_session/d_session.dart';
import 'package:get/get.dart';
import 'package:main/models/profile.dart';
import 'package:main/sources/profile_source.dart';

class ProfileController extends GetxController {
  final profile = Rxn<Profile>(); // bisa null
  Profile? get getProfile => profile.value;
  set setProfile(Profile? n) => profile.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  Future<void> loadFromSession() async {
    status = 'loading';
    final raw = await DSession.getUser();
    if (raw == null) {
      profile.value = null;
      status = 'empty';
      return;
    }
    profile.value = Profile.fromJson(Map<String, dynamic>.from(raw));
    status = 'success';
  }

  Future<String> saveProfile(Profile newProfile) async {
    // Ambil uid dari session (gunakan 'uid' atau fallback 'id')
    final raw = await DSession.getUser();
    if (raw == null) return 'not-logged-in';
    final map = Map<String, dynamic>.from(raw);
    final uid = (map['uid'] ?? map['id'] ?? '').toString();
    if (uid.isEmpty) return 'no-uid';

    final res = await ProfileSource.editProfile(uid, newProfile);
    if (res == 'success') {
      // Update state controller
      profile.value = newProfile;

      // Merge dan simpan kembali ke session
      map['name'] = newProfile.name;
      map['phoneNumber'] = newProfile.phoneNumber;
      map['address'] = newProfile.address;
      map['gender'] = newProfile.gender;
      map['profilePictureUrl'] = newProfile.profilePictureUrl;
      await DSession.setUser(map);
    }
    return res;
  }
}
