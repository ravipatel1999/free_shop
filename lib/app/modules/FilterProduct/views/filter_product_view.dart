import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/testStyle/input_Style.dart';
import '../controllers/filter_product_controller.dart';

class FilterProductView extends GetView<FilterProductController> {
  const FilterProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Filter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategories(),
              const SizedBox(height: 20),
              _buildBrands(),
              const SizedBox(height: 20),
              _buildPriceRange(),
              const SizedBox(height: 20),
              _buildRatings(),
              const SizedBox(height: 20),
              _buildSizes(),
              const SizedBox(height: 20),
              _buildColors(),
              const SizedBox(height: 20),
              SizedBox(
                height: 35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.carbonColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            'Apply',
                            style: AppStyles.appBarStyle,
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.resetFilters();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.carbonColor),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            'Reset',
                            style: AppStyles.btnStyle14,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: AppStyles.btnStyle14,
              ),
              const Text('View All'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Obx(() =>
        Wrap(
          spacing: 8,
          children: controller.categories
              .map((category) =>
                  _buildSelectableChip(category, controller.selectedCategory))
              .toList(),
        ),
        // ),
      ],
    );
  }

  Widget _buildRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rating'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: controller.ratings
              .map((rating) => _buildSelectableChip(
                  rating.toString(), controller.selectedRating))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBrands() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Brand',
                style: AppStyles.btnStyle14,
              ),
              const Text('View All'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Obx(() =>
        Wrap(
          spacing: 8,
          children: controller.brands
              .map((brand) =>
                  _buildSelectableChip(brand, controller.selectedBrand))
              .toList(),
          // ),
        ),
      ],
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price Range'),
        const SizedBox(height: 8),
        Obx(
          () => Column(
            children: [
              RangeSlider(
                activeColor: AppColors.carbonColor,
                inactiveColor: const Color(0xFFC7C6C6),
                values: RangeValues(
                  controller.minPrice.value,
                  controller.maxPrice.value,
                ),
                min: 1.0,
                max: 500.0,
                onChanged: (RangeValues values) {
                  controller.minPrice.value = values.start;
                  controller.maxPrice.value = values.end;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() =>
                      Text('₹${controller.minPrice.value.toStringAsFixed(2)}')),
                  Obx(() =>
                      Text('₹${controller.maxPrice.value.toStringAsFixed(2)}')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSizes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Size',
                style: AppStyles.btnStyle14,
              ),
              const Text('View All'),
            ],
          ),
        ),

        const SizedBox(height: 8),
        // Obx(() =>
        Wrap(
          spacing: 8,
          children: controller.sizes
              .map(
                  (size) => _buildSelectableChip(size, controller.selectedSize))
              .toList(),
          // ),
        ),
      ],
    );
  }

  Widget _buildColors() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color',
                  style: AppStyles.btnStyle14,
                ),
                GestureDetector(
                  onTap: () {
                    controller.showAllColors.value =
                        !controller.showAllColors.value;
                  },
                  child: Text(controller.showAllColors.value
                      ? 'View Less'
                      : 'View All'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: controller.colors
                .take(controller.showAllColors.value
                    ? controller.colors.length
                    : 5)
                .map((color) => _buildColorChip(color['name'],
                    Color(color['color']), controller.selectedColor))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableChip(String label, Rx<dynamic> dynamicValue) {
    return Obx(() {
      bool isDouble = dynamicValue.value is double;

      return ChoiceChip(
        selectedColor: AppColors.carbonColor,
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        side: const BorderSide(color: Colors.transparent),
        label: Text(
          label,
          style: TextStyle(
            color:
                dynamicValue.value == (isDouble ? double.parse(label) : label)
                    ? AppColors.whiteColor
                    : AppColors.hintColor,
          ),
        ),
        selected:
            dynamicValue.value == (isDouble ? double.parse(label) : label),
        onSelected: (bool selected) {
          if (selected) {
            dynamicValue.value = isDouble ? double.parse(label) : label;
          }
        },
        showCheckmark: false,
      );
    });
  }

  Widget _buildColorChip(String label, Color color, RxString selectedColor) {
    return Obx(
      () => ChoiceChip(
        side: const BorderSide(color: Colors.transparent),
        checkmarkColor: AppColors.whiteColor,
        backgroundColor: color,
        selectedColor: color,
        avatar: CircleAvatar(
          backgroundColor: color,
        ),
        label: const Text(''),
        selected: selectedColor.value == label,
        onSelected: (bool selected) {
          if (selected) {
            selectedColor.value = label;
          }
        },
      ),
    );
  }
}
