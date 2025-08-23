import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,

        // NOTE: Direkomendasikan menggunakan SizedBox dari flutter karna properties nya tidak banyak
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xff070623),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
