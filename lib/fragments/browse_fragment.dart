import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:main/controllers/booking_status_controller.dart';
import 'package:main/controllers/browse_feature_controller.dart';
import 'package:main/controllers/browse_newest_controller.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/failed_ui.dart';

class BrowseFragment extends StatefulWidget {
  const BrowseFragment({super.key});

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  final browseFeatureController = Get.put(BrowseFeatureController());
  final browseNewestController = Get.put(BrowseNewestController());
  final bookingStatusController = Get.put(BookingStatusController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      browseFeatureController.fetchFeatured();
      browseNewestController.fetchNewest();
      bookingStatusController.bike = {
        'id': 'bike_1',
        'name': 'Mountain Bike',
        'image':
            'https://res.cloudinary.com/djxobtcx0/image/upload/v1756301923/enfielding_pro_wwxnzd.png',
      };
    });
    super.initState();
  }

  // void dispose() {
  //   Get.delete<BrowseFeatureController>(force: true);
  //   Get.delete<BrowseNewestController>(force: true);
  //   super.dispose();
  // }
  @override
  void dispose() {
    if (Get.isRegistered<BrowseFeatureController>()) {
      Get.delete<BrowseFeatureController>(); // tanpa force
    }
    if (Get.isRegistered<BrowseNewestController>()) {
      Get.delete<BrowseNewestController>(); // tanpa force
    }
    if (Get.isRegistered<BookingStatusController>()) {
      Get.delete<BookingStatusController>(); // tanpa force
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Gap(30 + MediaQuery.of(context).padding.top),
        buildHeader(),
        buildBookingStatus(),
        const Gap(30),
        buildCategories(),
        const Gap(30),
        buildFeatured(),
        const Gap(30),
        buildNewest(),
        const Gap(150),
      ],
    );
  }

  Widget buildBookingStatus() {
    return Obx(() {
      Map bike = bookingStatusController.bike;
      // if (bike.isEmpty) {
      //   return const SizedBox();
      // }
      // final controller = Get.find<BookingStatusController>();
      // Map bike = controller.bike;

      if (bike.isEmpty) {
        return const SizedBox();
      }
      return Container(
        height: 96,
        margin: const EdgeInsets.fromLTRB(24, 30, 24, 0),
        decoration: BoxDecoration(
          color: const Color(0xff4A1DFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 16),
              blurRadius: 20,
              color: Color(0xff4A1DFF).withValues(alpha: 0.25),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: -20,
              top: 0,
              bottom: 0,
              child: ExtendedImage.network(
                bike['image'],
                height: 96,
                width: 96,
                fit: BoxFit.contain,
              ),
            ),
            const Gap(20),
            Positioned(
              top: 0,
              bottom: 0,
              left: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Your Booking ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: bike['name'],
                          style: const TextStyle(color: Color(0xffFFBC1C)),
                        ),
                        const TextSpan(text: "\nhas been delivered to."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildNewest() {
    // final categories = [
    //   ['assets/ic_city.png', 'City'],
    //   ['assets/ic_downhill.png', 'Downhill'],
    //   ['assets/ic_beach.png', 'Beach'],
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Newest Bikes',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff070623),
            ),
          ),
        ),
        Obx(() {
          String status = browseNewestController.status;

          if (status == '') {
            return const Center(child: CircularProgressIndicator());
          }

          if (status == 'loading') {
            return const Center(child: CircularProgressIndicator());
          }

          if (status != 'success') {
            return FailedUi(message: status);
          }

          List<Bike> list = browseNewestController.list;

          if (list.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: FailedUi(message: 'No featured bikes'),
            );
          }

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            itemCount: list.length,
            itemBuilder: (context, index) {
              Bike bike = list[index];
              final margin = EdgeInsets.only(
                top: index == 0 ? 10 : 9,
                bottom: index == list.length - 1 ? 20 : 9,
              );
              return buildItemNewest(bike, margin);
            },
          );
        }),
      ],
    );
  }

  Widget buildItemNewest(Bike bike, EdgeInsetsGeometry margin) {
    // final String imageStr = bike.image.trim();
    // final bool isNetwork = imageStr.startsWith('http');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: bike.id);
      },
      child: Container(
        height: 98,
        width: 345,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ExtendedImage.network(
              bike.image,
              height: 70,
              width: 90,
              fit: BoxFit.cover,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bike.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff070623),
                    ),
                  ),
                  const Gap(4),
                  Text(
                    bike.category,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff070623),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(10),

            Row(
              // TIPS : Ini sama aja kaya items end/start/between
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'en_US',
                    symbol: '\$',
                  ).format(bike.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6747E9),
                  ),
                ),
                Text(
                  "/day",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838385),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatured() {
    // final categories = [
    //   ['assets/ic_city.png', 'City'],
    //   ['assets/ic_downhill.png', 'Downhill'],
    //   ['assets/ic_beach.png', 'Beach'],
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Featured',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff070623),
            ),
          ),
        ),
        const Gap(10),

        Obx(() {
          String status = browseFeatureController.status;

          if (status == '') {
            return const Center(child: CircularProgressIndicator());
          }

          if (status == 'loading') {
            return const Center(child: CircularProgressIndicator());
          }

          if (status != 'success') {
            return FailedUi(message: status);
          }

          List<Bike> list = browseFeatureController.list;

          if (list.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: FailedUi(message: 'No featured bikes'),
            );
          }

          return SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                Bike bike = list[index];
                final margin = EdgeInsets.only(
                  left: index == 0 ? 24 : 12,
                  right: index == list.length - 1 ? 24 : 12,
                );
                bool isTrending = index == 0;
                return buildItemFeatured(bike, margin, isTrending);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildItemFeatured(
    Bike bike,
    EdgeInsetsGeometry margin,
    bool isTrending,
  ) {
    // final String imageStr = bike.image.trim();
    // final bool isNetwork = imageStr.startsWith('http');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: bike.id);
      },
      child: Container(
        width: 252,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ExtendedImage.network(bike.image, height: 170, width: 220),
                if (isTrending)
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFF2055),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          color: Color(0xffFF2056).withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 14,
                    ),
                    child: Text(
                      'Trending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),

            // TIPS: ini buat menambahkan space
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bike.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff070623),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        bike.category,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff070623),
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                  initialRating: bike.rating.toDouble(),
                  itemPadding: const EdgeInsets.all(0),
                  itemSize: 16,
                  unratedColor: Colors.grey[300],
                  allowHalfRating: true,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Color(0xffFFBC1C)),
                  ignoreGestures: true,
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            const Gap(16),
            Row(
              // TIPS : Ini sama aja kaya items end/start/between
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'en_US',
                    symbol: '\$',
                  ).format(bike.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6747E9),
                  ),
                ),
                Text(
                  "/day",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838385),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ...existing code...
  // ...existing code...
  Widget buildCategories() {
    final categories = [
      ['assets/ic_city.png', 'City'],
      ['assets/ic_downhill.png', 'Downhill'],
      ['assets/ic_beach.png', 'Beach'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff070623),
            ),
          ),
        ),
        const Gap(10),
        SingleChildScrollView(
          // TIPS: Ini untuk mengatur efek scroll nya (mirip IOS)
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: categories.map((category) {
                return Container(
                  height: 52,
                  margin: const EdgeInsets.only(right: 24),
                  // TIPS: INI KALO PADDING SETIAP SISI BEDA
                  padding: EdgeInsets.fromLTRB(16, 14, 30, 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(category[0], height: 24, width: 24),
                      const Gap(8),
                      Text(
                        category[1],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff070623),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/logo_text.png',
            height: 38,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_notification.png',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
