import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/booking_bike.dart';
import 'package:main/widgets/header.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.bike,
    required this.startDate,
    required this.endDate,
  });
  final Bike bike;
  final String startDate;
  final String endDate;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final totalBalance = 100;
  late int totalDurationDays; // dihitung di initState
  late num subTotal;
  late num insurance; // contoh 20%
  late num tax; // contoh 2%
  late num grandTotal;

  @override
  void initState() {
    super.initState();
    totalDurationDays = _calcDuration(widget.startDate, widget.endDate); // hari
    subTotal = totalDurationDays * widget.bike.price;

    // TODO: sesuaikan persen asuransinya
    insurance = subTotal * 0.20;

    // TODO: sesuaikan persen pajakanya
    tax = subTotal * 0.02;
    grandTotal = subTotal + insurance + tax;
  }

  int _calcDuration(String start, String end) {
    if (start.isEmpty || end.isEmpty) return 0;
    try {
      // Sesuaikan dengan format yang Anda pakai saat set di BookingPage: 'dd MMM yyyy'
      final fmt = DateFormat('dd MMM yyyy');
      final s = fmt.parse(start);
      final e = fmt.parse(end);
      final days = e.difference(s).inDays; // exclusive; pakai +1 jika inclusive
      return days < 0 ? 0 : days;
    } catch (_) {
      return 0;
    }
  }

  String _currency(num n) =>
      NumberFormat.currency(locale: 'en_US', symbol: '\$').format(n);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          Header(title: 'Checkout'),
          const Gap(24),
          BookingBike(bike: widget.bike),
          const Gap(24),
          buildDetails(),
          const Gap(24),
          buildPaymentMethod(),
        ],
      ),
    );
  }

  Widget buildDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        spacing: 14,
        children: [
          buildItemDetail('Price', _currency(widget.bike.price), '/day'),
          buildItemDetail('Start Date', widget.startDate, ''),
          buildItemDetail('End Date', widget.endDate, ''),
          buildItemDetail('Duration', '$totalDurationDays', ' days'),
          buildItemDetail('Sub Total Price', _currency(subTotal), ''),
          buildItemDetail('Insurance 20%', _currency(insurance), ''),
          buildItemDetail('Tax 2%', _currency(tax), ''),
          buildItemDetail(
            'Grand Total',
            _currency(grandTotal),
            '',
            isBlue: true,
          ),
        ],
      ),
    );
  }

  Widget buildItemDetail(
    String title,
    String data,
    String unit, {
    bool isBlue = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff838384),
          ),
        ),
        const Spacer(),
        Text(
          data,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(isBlue ? 0xff4A1DFF : 0xff070623),
          ),
        ),
        Text(
          unit,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff070623),
          ),
        ),
      ],
    );
  }

  Widget buildPaymentMethod() {
    final listPaymentMethod = <({String icon, String name})>[
      (icon: 'assets/wallet.png', name: 'My Wallet'),
      (icon: 'assets/cards.png', name: 'Credit Card'),
      (icon: 'assets/cash.png', name: 'Cash'),
    ];
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
            itemCount: listPaymentMethod.length,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == listPaymentMethod.length - 1 ? 24 : 8,
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
                      listPaymentMethod[index].icon,
                      width: 38,
                      height: 38,
                    ),
                    const Gap(10),
                    Text(
                      listPaymentMethod[index].name,
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
}
