class MobileSellModel {
  final String productBrand;
  final String productTitle;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  final List<String> images;
  final String uploadedBy;

  MobileSellModel({
    required this.productBrand,
    required this.productTitle,
    required this.productDescription,
    required this.productLocation,
    required this.productPrice,
    required this.images,
    required this.uploadedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'productBrand': productBrand,
      'productTitle': productTitle,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'productPrice': productPrice,
      'images': images,
      'uploadedBy': uploadedBy,
    };
  }

  factory MobileSellModel.fromMap(Map<String, dynamic> map) {
    return MobileSellModel(
      productBrand: map['productBrand'] ?? '',
      productTitle: map['productTitle'] ?? '',
      productDescription: map['productDescription'] ?? '',
      productLocation: map['productLocation'] ?? '',
      productPrice: map['productPrice'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      uploadedBy: map['uploadedBy'] ?? '',
    );
  }
}
