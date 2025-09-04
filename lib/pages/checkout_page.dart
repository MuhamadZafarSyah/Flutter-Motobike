import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/booking_bike.dart';
import 'package:main/widgets/header.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.bike,
    required this.startDate,
    required this.endDate,
  });
  final Bike bike;
  final String startDate;
  final String endDate;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          Header(title: 'Checkout'),
          const Gap(20),
          BookingBike(bike: widget.bike),
        ],
      ),
    );
  }
}
