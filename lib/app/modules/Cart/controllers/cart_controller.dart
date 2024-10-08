import 'package:get/get.dart';

enum SortOption {
  mostSuitable,
  popularity,
  topRated,
  priceHighToLow,
  priceLowToHigh
}

class CartController extends GetxController {
  var quantity = 1.obs;
  var categories = <String>['All', 'Cloth', 'Shoes', 'Bags', 'Mobile'].obs;
  var selectedIndex = 0.obs;

  void increment() {
    quantity++;
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
    update();
  }

  var selectedOption = SortOption.mostSuitable.obs;

  void setSelectedOption(SortOption option) {
    selectedOption.value = option;
  }

  // You can extend this with sorting logic for cart items based on the selected option.
  void sortItems() {
    // Add sorting logic here based on `selectedOption`
  }
  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  var items = <String>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchItems();
    cartItems.addAll([
      CartItem(
        name: 'Estelle Novelty Crossbody',
        price: 116.00,
        image: 'assets/sharess.png',
        size: 'L',
        color: 'Black',
        qty: 1,
      ),
      CartItem(
        name: 'Reebok Unisex-Adult Nano X4',
        price: 130.00,
        image: 'assets/Men_Shirts.png',
        size: 'M',
        color: 'Black',
        qty: 2,
      ),
      CartItem(
        name: 'Accutime Kids Disney Lilo',
        price: 50.00,
        image: 'assets/sharess.png',
        size: 'L',
        color: 'Black',
        qty: 1,
      ),
      CartItem(
        name: 'Lace Halter Mini Dress',
        price: 30.00,
        image: 'assets/Men_Shirts.png',
        size: 'L',
        color: 'Black',
        qty: 3,
      ),
    ]);
    super.onInit();
  }

  void fetchItems() async {
    await Future.delayed(Duration(seconds: 2));
    items.assignAll(
        ['Item 1', 'Item 2', 'Item 3', 'Item 1', 'Item 2', 'Item 3']);
    isLoading.value = false;
  }

  var cartItems = <CartItem>[].obs;

  // Total price calculation
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.qty));
}

// Cart Item model
class CartItem {
  final String name;
  final double price;
  final String image;
  final String size;
  final String color;
  int qty;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.size,
    required this.color,
    required this.qty,
  });
}
