import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 78,
        margin: const EdgeInsets.all(24),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xff070623),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildItemNav(
              label: 'Browse',
              icon: 'assets/ic_browse.png',
              iconOn: 'assets/ic_browse_on.png',
              onTap: () {},
            ),
            buildItemNav(
              label: 'Orders',
              icon: 'assets/ic_orders.png',
              iconOn: 'assets/ic_orders_on.png',
              onTap: () {},
            ),
            buildItemNav(
              label: 'Chats',
              icon: 'assets/ic_chats.png',
              iconOn: 'assets/ic_chats_on.png',
              onTap: () {},
              hasDot: true,
              isActive: true,
            ),
            buildItemNav(
              label: 'Settings',
              icon: 'assets/ic_settings.png',
              iconOn: 'assets/ic_settings_on.png',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemNav({
    required String label,
    required String icon,
    required String iconOn,
    bool isActive = false,
    required VoidCallback onTap,
    bool hasDot = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: 46,
        child: Column(
          children: [
            Image.asset(isActive ? iconOn : icon, width: 24, height: 24),
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,

                    // TIPS: BISA SEPERTI DI BAWAH INI ATAU BAWAHNYA LAGI
                    // color: isActive ? Colors.white : const Color(0xffFFBC1C),
                    color: Color(isActive ? 0xffFFBC1C : 0xffFFFFFF),
                  ),
                ),
                if (hasDot)
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xffFF2056),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
