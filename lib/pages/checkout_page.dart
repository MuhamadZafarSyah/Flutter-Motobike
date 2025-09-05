import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:main/models/account.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/booking_bike.dart';
import 'package:main/widgets/button_primary.dart';
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
  final totalBalance = 1000000;
  late int totalDurationDays; // dihitung di initState
  late num subTotal;
  late num insurance; // contoh 20%
  late num tax; // contoh 2%
  late num grandTotal;
  int _selectedPaymentMethod = -1;
  FToast fToast = FToast();

  void handleCheckout() {
    if (_selectedPaymentMethod == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    if (totalBalance < grandTotal) {
      Widget notifUi = Transform.translate(
        offset: const Offset(0, -50),
        child: Container(
          height: 96,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Color(0xffFF2055),
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
            'Failed to checkout. Your wallet has no enough balance at this moment.',
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );

      fToast.showToast(
        child: notifUi,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(milliseconds: 2500),
      );

      return;
    }

    Navigator.pushNamed(context, '/pin', arguments: widget.bike);
  }

  @override
  void initState() {
    super.initState();
    fToast.init(context);
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
        padding: const EdgeInsets.all(0),

        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          Header(title: 'Checkout'),
          const Gap(24),
          BookingBike(bike: widget.bike),
          const Gap(24),
          buildDetails(),
          const Gap(24),
          buildPaymentMethod(),
          const Gap(24),
          buildEwalletCard(),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(text: "Checkout Now", onTap: handleCheckout),
          ),
          const Gap(24),
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
              final isSelected = index == _selectedPaymentMethod;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 130,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 24 : 8,
                      right: index == listPaymentMethod.length - 1 ? 24 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Color(isSelected ? 0xff4A1DFF : 0xffE2E2E2),
                        width: isSelected ? 2 : 1,
                      ),
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
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildEwalletCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: FutureBuilder(
        future: DSession.getUser(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              heightFactor: 4,
              child: CircularProgressIndicator(),
            );
          }
          Account user = Account.fromJson(Map.from(asyncSnapshot.data!));
          return Stack(
            children: [
              Image.asset(
                'assets/bg_wallet.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '02/30',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      _currency(totalBalance),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
