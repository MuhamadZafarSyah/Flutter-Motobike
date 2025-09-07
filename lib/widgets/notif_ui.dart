import 'package:flutter/material.dart';

class NotifUi extends StatelessWidget {
  const NotifUi({super.key, required this.message, this.isSuccess = true});
  final String message;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -50),
      child: Container(
        height: 96,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Color(isSuccess ? 0xff00D930 : 0xffFF2055),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 16),
              color: const Color(0xffFF2055).withValues(alpha: 0.25),
            ),
          ],
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
