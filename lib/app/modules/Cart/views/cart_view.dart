import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/components/testStyle/input_Style.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        title: const Text(
          'Cart (15)',
          style: AppStyles.fontStyleSemiBold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  height: height * 0.05,
                  width: width,
                  color: Colors.transparent,
                  child: Container(
                    height: height * 0.05,
                    width: width,
                    color: Colors.transparent,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 15 : 5,
                              right: 5,
                            ),
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: () {
                                  controller.selectCategory(index);
                                  print('ravi$index');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.selectedIndex.value == index
                                          ? AppColors.carbonColor
                                          : const Color(0xFFEDEBEB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      controller.categories[index],
                                      style: TextStyle(
                                        color: controller.selectedIndex.value ==
                                                index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.3),
                            borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            // Item image
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: AppColors.whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 4.0),
                                child: CustomImageView(
                                  fit: BoxFit.contain,
                                  imagePath: item.image,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            // Item details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Size: ${item.size}'),
                                      Icon(Icons.more_vert)
                                    ],
                                  ),
                                  Text('Color: ${item.color}'),
                                  Text('Qty: 2'),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${item.price}',
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('\$90.00',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey.shade600))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
