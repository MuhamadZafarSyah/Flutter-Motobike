import 'package:flutter/material.dart';
import 'package:main/models/bike.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.bike});

  // TYPE NYA YANG ADA DI MODEL BIKE
  final Bike bike;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
