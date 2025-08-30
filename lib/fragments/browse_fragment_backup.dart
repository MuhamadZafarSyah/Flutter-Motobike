import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:main/controllers/browse_feature_controller.dart';
import 'package:main/models/bike.dart';
import 'package:main/widgets/failed_ui.dart';

class BrowseFragment extends StatefulWidget {
  const BrowseFragment({super.key});

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  final browseFeatureController = Get.put(BrowseFeatureController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      browseFeatureController.fetchFeatured();
    });
    super.initState();
  }

  // void dispose() {
  //   Get.delete<BrowseFeatureController>(force: true);
  //   super.dispose();
  // }
  @override
  void dispose() {
    if (Get.isRegistered<BrowseFeatureController>()) {
      Get.delete<BrowseFeatureController>(); // tanpa force
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
        const Gap(30),
        buildCategories(),
        const Gap(30),
        buildFeatured(),
      ],
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
    final String imageStr = bike.image.trim();
    final bool isNetwork = imageStr.startsWith('http');

    return Container(
      width: 252,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 220,
                  height: 170,
                  child: imageStr.isEmpty
                      ? Image.asset('assets/placeholder.png', fit: BoxFit.cover)
                      : isNetwork
                      ? Image.network(
                          imageStr,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Image.asset(
                            'assets/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                          loadingBuilder: (context, child, loading) {
                            if (loading == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                        )
                      : Image.asset(
                          imageStr,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Image.asset(
                            'assets/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              // Trending Badge
              if (isTrending)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFF2D92),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'TRENDING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(12),
          // Bike Name
          Text(
            bike.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(4),
          // Rating Stars
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < bike.rating.floor() ? Icons.star : Icons.star_border,
                  color: const Color(0xffFFB800),
                  size: 16,
                );
              }),
              const Gap(4),
              Text(
                bike.rating.toString(),
                style: const TextStyle(fontSize: 12, color: Color(0xff838383)),
              ),
            ],
          ),
          const Gap(8),
          // Price
          Text(
            '\$${bike.price.toInt()}/day',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff6366F1),
            ),
          ),
        ],
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
