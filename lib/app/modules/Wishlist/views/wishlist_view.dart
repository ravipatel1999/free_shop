import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/TextField/constant/app_color.dart';
import '../../../components/testStyle/input_Style.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: const Text(
            'WishList (15)',
            style: AppStyles.fontStyleSemiBold,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          toolbarHeight: 80,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list),
                        color: Colors.black,
                        padding: const EdgeInsets.all(0),
                        iconSize: 20,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<WishlistController>(
                      builder: (_) => ButtonsTabBar(
                        controller: controller.tabController,
                        elevation: 0,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        radius: 5,
                        backgroundColor: AppColors.carbonColor,
                        unselectedBackgroundColor: const Color(0xFFEBEBEB),
                        unselectedLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: const [
                          Tab(text: "All"),
                          Tab(text: "Men"),
                          Tab(text: "Women"),
                          Tab(text: "Shoe"),
                          Tab(text: "Cloth"),
                        ],
                        onTap: (index) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: GetBuilder<WishlistController>(
                  builder: (_) => TabBarView(
                    controller: controller.tabController,
                    children: [
                      buildProductGrid(),
                      buildProductGrid(),
                      buildProductGrid(),
                      buildProductGrid(),
                      buildProductGrid(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildProductGrid() {
    return Obx(
      () => GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return buildProductCard(product);
        },
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: CustomImageView(
                    imagePath: product.imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.hintColor,
                        size: 16,
                      ),
                      Text('${product.rating} (${product.sold} Sold)'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (product.oldPrice != null)
                        Text(
                          '\$${product.oldPrice}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            backgroundColor: AppColors.whiteColor,
            child: IconButton(
              icon: const Icon(
                Iconsax.heart5,
                color: AppColors.carbonColor,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
