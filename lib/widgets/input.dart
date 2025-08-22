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
      child: TextField(controller: editingController),
    );
  }
}
