import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/components/testStyle/input_Style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../../../components/TextField/form_text_field.dart';
import '../controllers/short_filter_controller.dart';

// ignore: must_be_immutable
class ShortFilterView extends GetView<ShortFilterController> {
  ShortFilterView({super.key});

  ShortFilterController shortFilterController =
      Get.put(ShortFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        toolbarHeight: 80,
        title: buildSearchBarSection(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GetBuilder<ShortFilterController>(
              builder: (_) => ButtonsTabBar(
                controller: controller.tabController,
                elevation: 0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
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
                  Tab(text: "Discover"),
                  Tab(text: "Men"),
                  Tab(text: "Women"),
                  Tab(text: "Shoe"),
                  Tab(text: "Cloth"),
                ],
                onTap: (index) {},
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: GetBuilder<ShortFilterController>(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.arrow_3),
                      SizedBox(width: 8),
                      Text(
                        'Short',
                        style: AppStyles.btnStyle2,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '|',
                        style: AppStyles.captionsText,
                      ),
                      SizedBox(width: 8),
                      Icon(Iconsax.filter_add1),
                      SizedBox(width: 8),
                      Text(
                        'Short',
                        style: AppStyles.btnStyle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(
                    product.imageUrl,
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
                Iconsax.heart,
                color: AppColors.hintColor,
                size: 15,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchBarSection() {
    return Row(
      children: [
        IconButton(
          icon: const CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.carbonColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Iconsax.arrow_left_2, color: AppColors.whiteColor),
              )),
          onPressed: () {
            Navigator.pop(Get.context!);
          },
        ),
        Expanded(
          child: CustomTextFormField(
            autofocus: false,
            height: 50,
            prefix: const Icon(
              Iconsax.search_normal,
              color: AppColors.primaryColor,
              size: 25,
            ),
            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            hintText: 'Search here...',
            labelText: 'Results',
            suffix: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.camera,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
