import 'package:get/get.dart';

class SearchProductController extends GetxController {
  var dressNames = [
    'T-Shirt',
    'Blouse',
    'Crop Top',
    'Tank Top',
    'Halter Top',
    'Tube Top',
    'Peplum Top',
    'Polo Shirt',
    'Camouflage Top',
    'Denim Shirt',
    'Bodysuit',
    'Wrap Top',
    'Hoodie',
    'Corset Top'
  ].obs;
  final count = 0.obs;
  var recentSearches = <String>[].obs;
  var recentdressNames = [
    'T-Shirt',
    'Blouse',
  ].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
