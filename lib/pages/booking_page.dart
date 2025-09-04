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
          const Gap(24),
          BookingBike(bike: widget.bike),
          const Gap(24),
          buildFormBooking(),
          const Gap(24),
          buildAgency(),
          const Gap(24),
          buildInsurance(),
          const Gap(24),
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
          const Gap(24),
        ],
      ),
    );
  }

  Widget buildInsurance() {
    final listInsurance = [
      'Select available insurance',
      'Jiwa Perkasa',
      'Kejiwaan',
      'Jiwa Perasaan',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Insurance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          const Gap(12),
          SizedBox(
            height: 52,
            child: DropdownButtonFormField(
              icon: UnconstrainedBox(
                child: Image.asset(
                  'assets/ic_arrow_down.png',
                  width: 18,
                  height: 18,
                ),
              ),
              items: listInsurance
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff070623),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,

                contentPadding: const EdgeInsets.only(right: 16),
                prefixIcon: UnconstrainedBox(
                  alignment: AlignmentGeometry.xy(0.2, 0),
                  child: Image.asset(
                    'assets/ic_insurance.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Color(0xff4A1DFF),
                    width: 2,
                  ),
                ),
              ),
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
