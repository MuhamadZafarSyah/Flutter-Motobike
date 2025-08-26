import 'package:flutter/material.dart';

class OrdersFragment extends StatelessWidget {
  const OrdersFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Orders Fragment',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
