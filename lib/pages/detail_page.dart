import 'dart:developer';

import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:main/common/info.dart';
import 'package:main/controllers/detail_bike_controller.dart';
import 'package:main/models/account.dart';
import 'package:main/models/bike.dart';
import 'package:main/models/chat.dart';
import 'package:main/sources/chat_source.dart';
import 'package:main/widgets/button_primary.dart';
import 'package:main/widgets/failed_ui.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.bikeId});
  final String bikeId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailBikeController = Get.put(DetailBikeController());
  late final Account account;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      detailBikeController.fetchDetailBike(widget.bikeId);
    });
    DSession.getUser().then((value) {
      account = Account.fromJson(Map.from(value!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          // Add your widgets here
          buildHeader(),
          const Gap(30),

          Obx(() {
            String status = detailBikeController.status;
            if (status == '') {
              return const Center(child: CircularProgressIndicator());
            }
            if (status == 'loading') {
              return const Center(child: CircularProgressIndicator());
            }
            if (status != 'success') {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: FailedUi(message: status),
              );
            }

            Bike bike = detailBikeController.bike;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      bike.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Color(0xff070623),
                      ),
                    ),
                  ),
                  const Gap(10),
                  buildStats(bike),
                  const Gap(30),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Image.asset('assets/ellipse.png', fit: BoxFit.fitWidth),
                      ExtendedImage.network(
                        bike.image,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  const Gap(30),
                  Text(
                    "About",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff070623),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    bike.about,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff070623),
                    ),
                  ),
                  const Gap(40),
                  buildPrice(bike),
                  const Gap(16),
                  buildSandMessage(bike),
                  const Gap(30),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/ic_arrow_back.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623),
              ),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Image.asset('assets/ic_favorite.png', width: 24, height: 24),
          ),
        ],
      ),
    );
  }

  Row buildStats(Bike bike) {
    final stats = [
      ['assets/ic_beach.png', bike.level],
      ['assets/ic_downhill.png', bike.category],
      ['assets/ic_star.png', '${bike.rating}/5'],
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stats.map((stat) {
        if (stat.isEmpty) return const Gap(20);
        return Row(
          children: [
            Image.asset(stat[0], width: 24, height: 24),
            const Gap(4),
            Text(
              stat[1],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff070623),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildPrice(Bike bike) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: const Color(0xff070623),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '/day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 132,
            child: ButtonPrimary(
              onTap: () {
                //
                Navigator.pushNamed(context, "/booking", arguments: bike);
              },
              text: "Book Now",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSandMessage(Bike bike) {
    return Material(
      color: Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {
          //
          String uid = account.uid;
          Chat chat = Chat(
            roomId: uid,
            receiverId: 'cs',
            senderId: uid,
            message: "Ready?",
            bikeDetail: {
              'id': bike.id,
              'name': bike.name,
              'image': bike.image,
              'price': bike.price,
              'category': bike.category,
            },
          );
          Info.netral("Loading...");
          ChatSource.openChatRoom(uid, account.name)
              .then((value) {
                ChatSource.sendMessage(chat, uid).then((value) {
                  Navigator.pushNamed(
                    // ignore: use_build_context_synchronously
                    context,
                    '/chatting',
                    arguments: {'uid': uid, 'userName': account.name},
                  );
                });
              })
              .catchError((e) {
                Info.error("Something went wrong!");
                log(e.toString());
              });
        },
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/ic_message.png', width: 24, height: 24),
              const Gap(10),
              Text(
                "Send Message",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff070623),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
