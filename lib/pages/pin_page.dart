import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:main/controllers/booking_status_controller.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/button_secondary.dart';
import 'package:main/widgets/header.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key, required this.bike});
  final Bike bike;

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final BookingStatusController bookingStatusController =
      Get.find<BookingStatusController>();
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();

  final isComplete = false.obs;

  tapPin(int number) {
    if (pin1.text == '') {
      pin1.text = '$number';
      return;
    }
    if (pin2.text == '') {
      pin2.text = '$number';
      return;
    }
    if (pin3.text == '') {
      pin3.text = '$number';
      return;
    }
    if (pin4.text == '') {
      pin4.text = '$number';
      isComplete.value = true;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),

        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          Header(title: 'Wallet Security'),
          const Gap(62),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputPIN(pin1),
                    const Gap(24),
                    inputPIN(pin2),
                    const Gap(24),
                    inputPIN(pin3),
                    const Gap(24),
                    inputPIN(pin4),
                  ],
                ),
                const Gap(50),
                buildNumberInput(),
              ],
            ),
          ),
          const Gap(50),
          buildActions(),
          const Gap(30),
        ],
      ),
    );
  }

  Widget buildNumberInput() {
    return SizedBox(
      width: 300,
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((number) {
          return Center(
            child: IconButton(
              onPressed: () => tapPin(number),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
              ),
              constraints: BoxConstraints(
                minHeight: 60,
                minWidth: 60,
                maxHeight: 60,
                maxWidth: 60,
              ),
              icon: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff070623),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget inputPIN(TextEditingController editingController) {
    InputBorder inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff070623), width: 3),
    );

    return SizedBox(
      width: 30,
      child: TextField(
        controller: editingController,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          enabled: false,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          border: inputBorder,
          disabledBorder: inputBorder,
        ),
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Color(0xff070623),
        ),
      ),
    );
  }

  Widget buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Obx(() {
            if (!isComplete.value) return const SizedBox();
            return ButtonPrimary(
              text: 'Pay Now',
              onTap: () {
                bookingStatusController.bike = {
                  'id': widget.bike.id,
                  'name': widget.bike.name,
                  'image': widget.bike.image,
                  'category': widget.bike.category,
                };

                Navigator.pushNamed(
                  context,
                  '/success-booking',
                  arguments: widget.bike,
                );
              },
            );
          }),

          const Gap(12),
          ButtonSecondary(
            text: 'Cancel',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
