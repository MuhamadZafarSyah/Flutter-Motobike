import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main/common/info.dart';
import 'package:main/sources/auth_source.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/button_secondary.dart';
import 'package:main/widgets/input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  actionSignIn() {
    if (edtEmail.text == '') return Info.error('Email must be filled');
    if (edtPassword.text == '') return Info.error('Password must be filled');

    Info.netral('loading..');

    AuthSource.signIn(edtEmail.text, edtPassword.text).then((message) {
      if (message != 'success') return Info.error(message);
      Info.success('Success Sign in');
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacementNamed(context, '/discover');
      });
    });
  }

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
            'Sign In Account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xff070623),
            ),
          ),
          const Gap(30),

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
          ButtonPrimary(text: "Sign In", onTap: actionSignIn),
          const Gap(30),
          const DottedLine(
            dashLength: 6,
            dashGapLength: 6,
            dashColor: Color(0xffCECED5),
          ),
          const Gap(30),
          ButtonSecondary(
            text: "Create New Account",
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
