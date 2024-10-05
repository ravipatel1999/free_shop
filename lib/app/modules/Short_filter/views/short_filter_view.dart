import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/short_filter_controller.dart';

class ShortFilterView extends GetView<ShortFilterController> {
  const ShortFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              // Category Filter Tabs
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildFilterTab('Discover', true),
                    buildFilterTab('Women', false),
                    buildFilterTab('Men', false),
                    buildFilterTab('Shoe', false),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Product Grid
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return buildProductCard(product);
                    },
                  ),
                ),
              ),
            ],
          ),
          // Positioned buttons
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement your filter action here
                  },
                  icon: Icon(Icons.filter_list),
                  label: Text('Filter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background color
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement your sort action here
                  },
                  icon: Icon(Icons.sort),
                  label: Text('Sort'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterTab(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Chip(
        label: Text(title),
        backgroundColor: isSelected ? Colors.black : Colors.grey.shade300,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (product.oldPrice != null)
                      Text(
                        '\$${product.oldPrice}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Text('${product.rating} (${product.sold} Sold)'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Heart icon on top right of the product card
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24, // Adjust size as needed
              ),
              onPressed: () {
                // Implement your favorite action here
              },
            ),
          ),
        ],
      ),
    );
  }
}
