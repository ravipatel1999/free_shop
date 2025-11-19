class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double mrp;
  final double discount;
  final int totalQty;
  final String group;
  final String category;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.mrp,
    required this.discount,
    required this.totalQty,
    required this.group,
    required this.category,
    required this.images,
  });
}

class ProductImage {
  final String angle;
  final String fileUrl;

  ProductImage({
    required this.angle,
    required this.fileUrl,
  });
}

class Company {
  final String id;
  final String namePrint;
  final String code;

  Company({
    required this.id,
    required this.namePrint,
    required this.code,
  });
}
