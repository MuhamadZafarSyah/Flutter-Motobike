import 'dart:developer';

import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/common/info.dart';
import 'package:main/models/account.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  logout() async {
    try {
      final removed = await DSession.removeUser();

      if (!mounted) return;

      if (!removed) {
        Info.error('Failed to logout');
        return;
      }

      Info.success('Successfully logged out');
      Navigator.pushReplacementNamed(context, '/signin');
    } catch (e) {
      if (!mounted) return; // Cek mounted di catch juga
      Info.error('Failed to logout');
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Gap(30 + MediaQuery.of(context).padding.top),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'My Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xff070623),
            ),
          ),
        ),
        const Gap(20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              buildProfileInfo(),
              const Gap(30),
              buildItemSetting('assets/ic_profile.png', 'Edit Profile', null),
              const Gap(20),
              buildItemSetting(
                'assets/ic_wallet.png',
                'My Digital Wallet',
                null,
              ),
              const Gap(20),
              buildItemSetting('assets/ic_rate.png', 'Rate This App', null),
              const Gap(20),
              buildItemSetting('assets/ic_key.png', 'Change Password', null),
              const Gap(20),
              buildItemSetting(
                'assets/ic_interest.png',
                'Internest Personalized',
                null,
              ),
              const Gap(20),
              buildItemSetting('assets/ic_logout.png', 'Logout', logout),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItemSetting(String icon, String name, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xffEFEEF7), width: 1),
        ),
        child: Row(
          children: [
            Image.asset(icon, height: 24, width: 24),
            const Gap(16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  color: Color(0xff070623),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Image.asset('assets/ic_arrow_next.png', height: 20, width: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileInfo() {
    return FutureBuilder(
      future: DSession.getUser(),
      builder: (context, snapshoot) {
        if (snapshoot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        Account account = Account.fromJson(Map.from(snapshoot.data!));

        return Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623),
                  ),
                ),
                Gap(2),
                Text(
                  account.email,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838384),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
