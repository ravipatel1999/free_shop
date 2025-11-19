// lib/app/modules/ProductDetails/views/product_details_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';
import '../models/product_details_models.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [_buildCartIcon(context), const SizedBox(width: 10)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildContent(context),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartIcon(BuildContext context) {
    final theme = Theme.of(context);
    final cartController = Get.find<CartController>();

    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: IconButton(
            icon: Icon(
              Iconsax.shopping_cart,
              color: theme.colorScheme.onSurface,
              size: 20,
            ),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ),
        Obx(() => cartController.cartItemCount.value > 0
            ? Positioned(
                right: 2,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    cartController.cartItemCount.value.toString(),
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : const SizedBox()),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoadingState(context);
      }

      if (controller.product.value.id.isEmpty) {
        return _buildErrorState(context);
      }

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildImageSection(context)),
          SliverToBoxAdapter(child: _buildProductInfo(context)),
          SliverToBoxAdapter(child: _buildProductDescription(context)),
          SliverToBoxAdapter(child: _buildInventorySection(context)),
          SliverToBoxAdapter(child: _buildSpecifications(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      );
    });
  }

  Widget _buildLoadingState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Loading Product...',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 50,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Product Not Found',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The product you\'re looking for is not available or has been removed.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Get.back(),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    return Obx(() {
      final images = product.images;
      final hasImages = images.isNotEmpty;

      return Container(
        height: 360,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
        ),
        child: Stack(
          children: [
            // Main Image
            if (hasImages)
              PageView.builder(
                itemCount: images.length,
                onPageChanged: (index) =>
                    controller.currentImageIndex.value = index,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: images[index].fileUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Container(
                      color: theme.colorScheme.surfaceContainer,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: theme.colorScheme.surfaceContainer,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.gallery_slash,
                              size: 60,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.3),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                color: theme.colorScheme.surfaceContainer,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.gallery_remove,
                        size: 80,
                        color: theme.colorScheme.onSurface.withOpacity(0.3),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No Images Available',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Image Indicators
            if (hasImages && images.length > 1)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width:
                          controller.currentImageIndex.value == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: controller.currentImageIndex.value == index
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),

            // Discount Badge
            if (controller.getDiscountPercentage() > 0)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${controller.getDiscountPercentage().toInt()}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildProductInfo(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            product.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Product Code
          Text(
            'SKU: ${product.itemCode}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),

          // Price Section
          _buildPriceSection(context),
          const SizedBox(height: 16),

          // Stock & Category
          _buildStockAndCategory(context),
        ],
      ),
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;
    final hasDiscount = controller.getDiscountPercentage() > 0;

    return Row(
      children: [
        // Current Price
        Text(
          '₹${product.price.toStringAsFixed(0)}',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 12),

        if (hasDiscount) ...[
          // Original Price
          Text(
            '₹${product.mrp.toStringAsFixed(0)}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 8),

          // You Save
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.green.withOpacity(0.2)),
            ),
            child: Text(
              'Save ₹${(product.mrp - product.price).toStringAsFixed(0)}',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStockAndCategory(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Stock Status - FIXED: Check product availability properly
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: controller.isProductAvailable
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: controller.isProductAvailable
                  ? Colors.green.withOpacity(0.3)
                  : Colors.red.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                controller.isProductAvailable
                    ? Iconsax.tick_circle
                    : Iconsax.close_circle,
                size: 14,
                color:
                    controller.isProductAvailable ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
              Text(
                controller.isProductAvailable ? 'In Stock' : 'Out of Stock',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      controller.isProductAvailable ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),

        // Category
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.category_2,
                size: 14,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                product.category,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Group
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.box,
                size: 14,
                color: Colors.blue,
              ),
              const SizedBox(width: 6),
              Text(
                product.group,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductDescription(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.longDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventorySection(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    if (product.godownDetails.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inventory Details',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...product.godownDetails
              .map((godown) => _buildGodownTile(context, godown)),
        ],
      ),
    );
  }

  Widget _buildGodownTile(BuildContext context, GodownDetail godown) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.buildings_2,
              size: 16,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  godown.godownName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  godown.batchName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${godown.qty} units',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifications(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specifications',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: Column(
              children: [
                _buildSpecRow(context, 'Product Group', product.group),
                _buildDivider(context),
                _buildSpecRow(context, 'Category', product.category),
                _buildDivider(context),
                _buildSpecRow(
                    context, 'Available Quantity', '${product.totalQty} units'),
                if (product.discount > 0) ...[
                  _buildDivider(context),
                  _buildSpecRow(context, 'Discount',
                      '₹${product.discount.toStringAsFixed(0)}'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // View Cart Button (ALWAYS shows when cart has items)
            Obx(() => controller.shouldShowViewCart
                ? _buildViewCartButton(context)
                : const SizedBox()),

            // Main Action Buttons
            Obx(() {
              final isInCart = controller.isProductInCart.value;
              final isLoading = controller.isLoadingAddToCart.value;
              final showBulkInput = controller.showBulkInput.value;

              // Check product availability using the fixed method
              if (!controller.isProductAvailable) {
                return _buildOutOfStockButton(context);
              }

              if (showBulkInput) {
                return _buildBulkQuantityInput(context);
              }

              if (isInCart) {
                return _buildCartControls(context);
              }

              return _buildAddToCartButton(context, isLoading);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildViewCartButton(BuildContext context) {
    final theme = Theme.of(context);
    final cartController = Get.find<CartController>();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.navigateToCart,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.9),
                  theme.colorScheme.primary,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Iconsax.shopping_cart,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View Cart',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(() => Text(
                              '${cartController.cartItemCount.value} ${cartController.cartItemCount.value == 1 ? 'item' : 'items'} • ₹${cartController.subtotal.value.toStringAsFixed(0)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.arrow_right_3,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutOfStockButton(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.close_circle,
                color: theme.colorScheme.onSurface.withOpacity(0.3)),
            const SizedBox(width: 8),
            Text(
              'Out of Stock',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, bool isLoading) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Bulk Quantity Toggle
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: IconButton(
            onPressed: () => controller.toggleBulkInput(),
            icon: Icon(
              Iconsax.additem,
              color: theme.colorScheme.primary,
            ),
            tooltip: 'Bulk Quantity',
          ),
        ),
        const SizedBox(width: 12),

        // Add to Cart Button
        Expanded(
          child: SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: isLoading ? null : () => controller.addToCart(),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onPrimary,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.shopping_cart, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Add to Cart',
                          style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.cardColor),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartControls(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuantityButton(
                    context,
                    icon: Iconsax.minus,
                    onTap: controller.decrementQuantity,
                    isLoading: controller.isLoadingDecrement.value,
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Obx(() => Text(
                          controller.bulkQuantity.value.toString(),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        )),
                  ),
                ),

                // Increment Button
                Expanded(
                  child: _buildQuantityButton(
                    context,
                    icon: Iconsax.add,
                    onTap: controller.incrementQuantity,
                    isLoading: controller.isLoadingIncrement.value,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Bulk Input & Remove Buttons
        Row(
          children: [
            // Bulk Input Toggle
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: IconButton(
                onPressed: () => controller.toggleBulkInput(),
                icon: Icon(
                  Iconsax.edit_2,
                  color: theme.colorScheme.primary,
                ),
                tooltip: 'Edit Quantity',
              ),
            ),
            const SizedBox(width: 8),

            // Remove from Cart
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 0.5,
                  color: theme.colorScheme.error,
                ),
              ),
              child: IconButton(
                onPressed: controller.removeFromCart,
                icon: Icon(
                  Iconsax.trash,
                  color: theme.colorScheme.error,
                ),
                tooltip: 'Remove from Cart',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    required bool isLoading,
  }) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: isLoading
              ? SizedBox(
                  width: 5,
                  height: 10,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
              : Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
        ),
      ),
    );
  }

  Widget _buildBulkQuantityInput(BuildContext context) {
    final theme = Theme.of(context);
    final product = controller.product.value;

    return Column(
      children: [
        // Input Row
        Row(
          children: [
            // Quantity Input
            Expanded(
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: TextField(
                  controller: controller.bulkQuantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: '1',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Max: ${product.totalQty}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  onChanged: controller.updateBulkQuantity,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Apply Button
            SizedBox(
              width: 100,
              height: 54,
              child: FilledButton(
                onPressed: controller.setBulkQuantityManually,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Cancel Button
        SizedBox(
          width: double.infinity,
          height: 44,
          child: OutlinedButton(
            onPressed: () => controller.toggleBulkInput(),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
