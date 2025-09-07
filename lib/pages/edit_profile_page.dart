import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:main/controllers/profile_controller.dart';
import 'package:main/models/profile.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/input.dart';
import 'package:main/widgets/notif_ui.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final edtName = TextEditingController();
  final edtPhone = TextEditingController();
  final edtAddress = TextEditingController();
  String gender = ''; // 'male' / 'female' / ''

  final profileUser = Get.put(ProfileController());

  FToast fToast = FToast();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    _prefill();
  }

  Future<void> _prefill() async {
    await profileUser.loadFromSession();
    final p = profileUser.getProfile;
    if (p != null) {
      edtName.text = p.name;
      edtPhone.text = p.phoneNumber;
      edtAddress.text = p.address;
      gender = p.gender;
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    edtName.dispose();
    edtPhone.dispose();
    edtAddress.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    // Validasi sederhana
    if (edtName.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name is required')));
      return;
    }
    final current = profileUser.getProfile ?? Profile.empty;
    final toSave = current.copyWith(
      name: edtName.text.trim(),
      phoneNumber: edtPhone.text.trim(),
      address: edtAddress.text.trim(),
      gender: gender,
    );

    final res = await profileUser.saveProfile(toSave);
    if (!mounted) return;
    if (res == 'success') {
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text('Profile updated')));

      fToast.showToast(
        child: NotifUi(
          message: 'Your Profile updated\nSuccessfully',
          isSuccess: true,
        ),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(milliseconds: 2500),
      );
      Navigator.pop(context);
    } else {
      fToast.showToast(
        child: NotifUi(message: 'Failed: $res', isSuccess: false),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(milliseconds: 2500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(24),

          const Text(
            'Detail Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          const Gap(12),

          const Text(
            'Full Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'Enter your name',
            editingController: edtName,
            icon: 'assets/ic_profile.png',
          ),
          const Gap(16),

          const Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'Enter your phone number',
            editingController: edtPhone,
            icon: 'assets/ic_send.png',
            inputType: TextInputType.number,
          ),
          const Gap(16),

          const Text(
            'Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'Enter your address',
            editingController: edtAddress,
            icon: 'assets/ic_city.png',
          ),
          const Gap(16),

          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          const Gap(8),
          DropdownButtonFormField<String>(
            initialValue: gender.isEmpty ? null : gender,
            items: const [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
            ],
            onChanged: (v) => setState(() => gender = v ?? ''),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color(0xff4A1DFF),
                  width: 2,
                ),
              ),
            ),
          ),

          const Gap(24),
          ButtonPrimary(text: 'Save Changes', onTap: _onSave),
          const Gap(32),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SizedBox(
            height: 46,
            width: 46,
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff070623),
              size: 16,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Edit Profile',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623),
              ),
            ),
          ),
        ),
        const SizedBox(width: 46), // spacer kanan
      ],
    );
  }
}
