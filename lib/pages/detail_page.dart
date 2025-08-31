import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main/controllers/detail_bike_controller.dart';
import 'package:main/models/account.dart';

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
          // Add your widgets here
        ],
      ),
    );
  }
}
