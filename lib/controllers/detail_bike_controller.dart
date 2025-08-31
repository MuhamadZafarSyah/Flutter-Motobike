import 'package:get/get.dart';
import 'package:main/models/bike.dart';
import 'package:main/sources/bike_source.dart';

class DetailBikeController extends GetxController {
  final Rx<Bike> _bike = Bike.empty.obs;
  Bike get bike => _bike.value;
  set bike(Bike n) => _bike.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  fetchDetailBike(String bikeId) async {
    status = 'loading';

    final bikeDetail = await BikeSource.fetchBike(bikeId);
    if (bikeDetail == null) {
      status = 'something went wrong';
      return;
    }

    status = 'success';
    bike = bikeDetail;
  }
}
