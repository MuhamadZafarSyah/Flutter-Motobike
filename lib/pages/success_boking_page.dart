import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/button_secondary.dart';

class SuccessBokingPage extends StatelessWidget {
  const SuccessBokingPage({super.key, required this.bike});
  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const Gap(80),
          Text(
            'Success Booking\nHave a Great Ride!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xff070623),
            ),
            textAlign: TextAlign.center,
          ),

          const Gap(80),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image.asset('assets/ellipse.png', fit: BoxFit.fitWidth),
              ExtendedImage.network(bike.image, height: 250, fit: BoxFit.cover),
            ],
          ),

          const Gap(30),
          Text(
            bike.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Text(
            bike.category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
            textAlign: TextAlign.center,
          ),

          const Gap(50),
          ButtonPrimary(
            text: "Booking Other Bike",
            onTap: () {
              Navigator.restorablePushNamedAndRemoveUntil(
                context,
                '/discover',
                (route) => route.settings.name == '/detail',
              );
            },
          ),

          const Gap(12),
          ButtonSecondary(
            text: "View My Orders",
            onTap: () {
              Navigator.restorablePushNamedAndRemoveUntil(
                context,
                '/discover',
                (route) => route.settings.name == '/detail',
              );
            },
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
