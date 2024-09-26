import 'package:get/get.dart';

class FilterProductController extends GetxController {
  RxString selectedCategory = 'Women'.obs;
  RxString selectedBrand = 'Adidas'.obs;
  RxDouble minPrice = 80.0.obs;
  RxDouble maxPrice = 120.0.obs;
  RxDouble selectedRating = 2.4.obs;
  RxString selectedSize = 'XXS'.obs;
  RxString selectedColor = 'Black'.obs;

  List<String> categories = [
    'Women',
    'Men',
    'Shoe',
    'Bag',
    'Luxury',
    'Kid',
    'Sports',
    'Beauty',
    'Lifestyle',
    'Other'
  ];
  List<String> brands = ['Adidas', 'Nick', 'Xerox', 'Vans'];
  List<String> sizes = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45'
  ];
  List<double> ratings = [2.4, 4.4, 6.8];
  var showAllColors = false.obs;
  List<Map<String, dynamic>> colors = [
    {'name': 'Black', 'color': 0xFF000000},
    {'name': 'Red', 'color': 0xFFFF0000},
    {'name': 'Purple', 'color': 0xFF800080},
    {'name': 'Violet', 'color': 0xFFEE82EE},
    {'name': 'Blue', 'color': 0xFF0000FF}, // New color
    {'name': 'Green', 'color': 0xFF008000}, // New color
    {'name': 'Yellow', 'color': 0xFFFFFF00}, // New color
    {'name': 'Orange', 'color': 0xFFFFA500}, // New color
    {'name': 'Pink', 'color': 0xFFFFC0CB}, // New color
  ];

  void resetFilters() {
    selectedCategory.value = 'Women';
    selectedBrand.value = 'Adidas';
    minPrice.value = 80.0;
    maxPrice.value = 120.0;
    selectedRating.value = 2.4;
    selectedSize.value = 'XXS';
    selectedColor.value = 'Black';
  }
}
