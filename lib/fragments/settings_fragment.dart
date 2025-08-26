import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsFragment extends StatelessWidget {
  const SettingsFragment({super.key});

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
      ],
    );
  }
}
