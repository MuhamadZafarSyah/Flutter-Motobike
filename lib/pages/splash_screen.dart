import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/widgets/button_primary.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(70),
          Image.asset('assets/logo_text.png', height: 38, width: 171),
          const Gap(10),
          Text(
            'Drive & Be Happy!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,

              // TIPS: kalo di flutter ga pakai # tapi pakai 0xff
              color: Color(0xff070623),
            ),
          ),
          const Gap(10),
          Image.asset('assets/splash_screen.png', height: 372, width: 416),
          const Gap(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'We provide all beautiful motorbike for your road trip and great memories of life.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

                // TIPS: kalo di flutter ga pakai # tapi pakai 0xff
                color: Color(0xff070623),
              ),
            ),
          ),
          const Gap(30),
          ButtonPrimary(text: "Explore Now", onTap: () {}),
        ],
      ),
    );
  }

  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset('assets/logo_text.png', width: 38, height: 171),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
