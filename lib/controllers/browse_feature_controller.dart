import 'package:get/get.dart';
import 'package:main/models/bike.dart';
import 'package:main/sources/bike_source.dart';

class BrowseFeatureController extends GetxController {
  final _list = <Bike>[].obs;
  List<Bike> get list => _list;
  set list(List<Bike> n) => _list.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  fetchFeatured() async {
    status = 'loading';
    final bikes = await BikeSource.fetchFeaturedBikes();

    if (bikes == null) {
      status = 'something went wrong';
      return;
    }

    status = 'success';
    list = bikes;
  }
}
