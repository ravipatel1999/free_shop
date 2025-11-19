// lib/app/modules/ProductDetails/models/product_details_models.dart
class ProductDetailsModels {
  String id;
  String name;
  String description;
  String longDescription;
  String itemCode;
  String group;
  String category;
  int totalQty;
  double mrp;
  double discount;
  double price;
  List<ProductImage> images;
  List<GodownDetail> godownDetails;

  ProductDetailsModels({
    this.id = '',
    this.name = '',
    this.description = '',
    this.longDescription = '',
    this.itemCode = '',
    this.group = '',
    this.category = '',
    this.totalQty = 0,
    this.mrp = 0.0,
    this.discount = 0.0,
    this.price = 0.0,
    this.images = const [],
    this.godownDetails = const [],
  });

  factory ProductDetailsModels.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModels(
      id: json['_id']?.toString() ?? '',
      name: json['ItemName']?.toString() ?? '',
      description: json['description']?.toString() ??
          'Premium ${json['ItemName']?.toString() ?? 'Product'}',
      longDescription: json['longDescription']?.toString() ??
          'Experience premium quality with ${json['ItemName']?.toString() ?? 'this product'}. Designed for excellence and built to last.',
      itemCode: json['ItemCode']?.toString() ?? '',
      group: json['Group']?.toString() ?? '',
      category: json['Category']?.toString() ?? '',
      totalQty: (json['TotalQty'] as num?)?.toInt() ?? 0,
      mrp: (json['MRP'] as num?)?.toDouble() ?? 0.0,
      discount: (json['Discount'] as num?)?.toDouble() ?? 0.0,
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      images: json['productId'] != null && json['productId']['images'] != null
          ? List<ProductImage>.from(
              json['productId']['images'].map((x) => ProductImage.fromJson(x)))
          : [],
      godownDetails: json['GodownDetails'] != null
          ? List<GodownDetail>.from(
              json['GodownDetails'].map((x) => GodownDetail.fromJson(x)))
          : [],
    );
  }
}

class ProductImage {
  String angle;
  String fileUrl;
  String previewUrl;

  ProductImage({
    required this.angle,
    required this.fileUrl,
    required this.previewUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      angle: json['angle']?.toString() ?? 'Front',
      fileUrl: json['fileUrl']?.toString() ?? '',
      previewUrl: json['previewUrl']?.toString() ?? '',
    );
  }
}

class GodownDetail {
  String godownName;
  String batchName;
  int qty;

  GodownDetail({
    required this.godownName,
    required this.batchName,
    required this.qty,
  });

  factory GodownDetail.fromJson(Map<String, dynamic> json) {
    return GodownDetail(
      godownName: json['GodownName']?.toString() ?? '',
      batchName: json['BatchName']?.toString() ?? '',
      qty: (json['Qty'] as num?)?.toInt() ?? 0,
    );
  }
}
