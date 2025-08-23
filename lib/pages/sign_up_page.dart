import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/button_secondary.dart';
import 'package:main/widgets/input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const Gap(100),
          Image.asset('assets/logo_text.png', height: 38, width: 171),
          const Gap(70),
          Text(
            'Sign Up Account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xff070623),
            ),
          ),
          const Gap(30),
          Text(
            'Complete Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          const Gap(12),
          Input(
            hint: 'write your real email',
            editingController: edtName,
            icon: 'assets/ic_profile.png',
          ),
          const Gap(20),
          Text(
            'Email Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'write your real email',
            editingController: edtEmail,
            icon: 'assets/ic_email.png',
          ),
          const Gap(20),
          Text(
            'Password',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'write your password',
            editingController: edtPassword,
            icon: 'assets/ic_key.png',
            obscure: true,
          ),
          const Gap(30),
          ButtonPrimary(
            text: "Create New Account",
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
          ),
          const Gap(30),
          const DottedLine(
            dashLength: 6,
            dashGapLength: 6,
            dashColor: Color(0xffCECED5),
          ),
          const Gap(30),
          ButtonSecondary(
            text: "Sign In",
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
