import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/booking_bike.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/header.dart';
import 'package:main/widgets/input.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.bike});

  // TYPE NYA YANG ADA DI MODEL BIKE
  final Bike bike;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final edtName = TextEditingController();
  final edtStartDate = TextEditingController();
  final edtEndDate = TextEditingController();

  pickDate(TextEditingController editingController) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      editingController.text = DateFormat('dd MMM yyyy').format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          Header(title: 'Booking'),
          const Gap(20),
          BookingBike(bike: widget.bike),
          const Gap(20),
          buildFormBooking(),
          const Gap(20),
          buildAgency(),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              text: "Proceed to Checkout",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/checkout',
                  arguments: {
                    'bike': widget.bike,
                    'startDate': edtStartDate.text,
                    'endDate': edtEndDate.text,
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAgency() {
    final listAgency = ['Revolte', 'KBP City', 'Sumadap'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const Text(
            'Agency',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
        ),
        const Gap(12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: listAgency.length,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == listAgency.length - 1 ? 24 : 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: index == 1
                      ? Border.all(width: 3, color: const Color(0xff4A1DFF))
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExtendedImage.asset(
                      'assets/agency.png',
                      width: 38,
                      height: 38,
                    ),
                    const Gap(10),
                    Text(
                      listAgency[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff070623),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildFormBooking() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            hint: 'Write your real name',
            editingController: edtName,
            icon: 'assets/ic_profile.png',
          ),
          const Gap(20),
          Text(
            'Start Rent Date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'Choose your date',
            editingController: edtStartDate,
            icon: 'assets/ic_calendar.png',
            enable: false,
            onTapBox: () => pickDate(edtStartDate),
          ),
          const Gap(20),
          Text(
            'End Date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Input(
            hint: 'Choose your date',
            editingController: edtEndDate,
            icon: 'assets/ic_calendar.png',
            enable: false,
            onTapBox: () => pickDate(edtEndDate),
          ),
        ],
      ),
    );
  }
}
