import 'package:flutter/material.dart';

class BrowseFragment extends StatelessWidget {
  const BrowseFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Browse Fragment',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
