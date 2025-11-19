import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'address_card.dart';
import 'bill_details.dart';
import 'cart_items_container.dart';
import 'confirm_button.dart';

class CartContent extends GetView<CartController> {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AddressCard(size: size, theme: theme),
            ),
            SliverToBoxAdapter(
              child: CartItemsContainer(size: size, theme: theme),
            ),
            SliverToBoxAdapter(
              child: BillDetails(size: size, theme: theme),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: size.height * 0.30),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ConfirmButton(size: size, theme: theme),
        ),
      ],
    );
  }
}
