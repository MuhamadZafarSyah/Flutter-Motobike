import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.icon,
    required this.hint,
    required this.editingController,
    this.obscure,
    this.enable = true,
    this.onTapBox,
  });

  // Properties
  //ini agar inputan nya ada menambahkan icon
  final String? icon;

  // placeholder inputan
  final String hint;

  // controller untuk inputan
  final TextEditingController editingController;
  final bool? obscure;

  // INI NANTI BERFUNGSI JIKA INPUTAN TIDAK HANYA INPUT TEXT TAPI JUGA INPUT LAINNYA CNTH: DATE PICKER
  final bool enable;
  final VoidCallback? onTapBox;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBox,

      child: TextField(
        controller: editingController,

        // JIKA ADA ICON MAKA TAMBAHKAN
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff070623),
        ),

        obscureText: obscure ?? false,
        decoration: InputDecoration(
          enabled: enable,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff070623),
          ),
          // prefixIcon: icon != null
          //     ? Padding(
          //         padding: const EdgeInsets.all(12.0),
          //         child: Image.asset(icon!),
          //       )
          //     : null,
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          fillColor: const Color(0xffFFFFFF),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(width: 2, color: Color(0xff4A1DFF)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          isDense: true,

          // TIPS: gunakan UnconstrainedBox tidak terpengaruhi oleh box pembungkusnya, sehingga dia mengikuti width dan size dari image nya
          prefixIcon: UnconstrainedBox(
            alignment: const Alignment(0.4, 0),
            child: Image.asset(icon!, width: 24, height: 24),
          ),
          // TIPS: isDense ini sama aja kaya reset padding
        ),
      ),
    );
  }
}
