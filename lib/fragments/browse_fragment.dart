import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BrowseFragment extends StatelessWidget {
  const BrowseFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [Gap(30 + MediaQuery.of(context).padding.top), buildHeader()],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/logo_text.png',
            height: 38,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_notification.png',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
