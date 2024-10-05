import 'package:get/get.dart';

class DashbordController extends GetxController {
  final count = 0.obs;
  var selectedIndex = 0.obs;
  var items = <CarouselItem>[
    CarouselItem(
      imageUrl: "assets/Men_Shirts.png",
      title: '50% offer',
      subtitle: 'on everything today',
    ),
    CarouselItem(
      imageUrl: 'assets/Men_Shirts.png',
      title: '80% offer',
      subtitle: 'on everything today',
    ),
  ].obs;

  var categories = <String>['All', 'Cloth', 'Shoes', 'Bags', 'Mobile'].obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
    update();
  }

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

class CarouselItem {
  final String imageUrl;
  final String title;
  final String subtitle;

  CarouselItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}
