class AccessoryHeadphonesModel {
  final String headphoneType;
  final String productCondition;
  final String productTitle;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  final List<String> images;
  final String uploadedBy;

  AccessoryHeadphonesModel({
    required this.headphoneType,
    required this.productCondition,
    required this.productTitle,
    required this.productDescription,
    required this.productLocation,
    required this.productPrice,
    required this.images,
    required this.uploadedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'headphoneType': headphoneType,
      'productCondition': productCondition,
      'productTitle': productTitle,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'productPrice': productPrice,
      'images': images,
      'uploadedBy': uploadedBy,
    };
  }

  factory AccessoryHeadphonesModel.fromMap(Map<String, dynamic> map) {
    return AccessoryHeadphonesModel(
      headphoneType: map['headphoneType'] ?? '',
      productCondition: map['productCondition'] ?? '',
      productTitle: map['productTitle'] ?? '',
      productDescription: map['productDescription'] ?? '',
      productLocation: map['productLocation'] ?? '',
      productPrice: map['productPrice'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      uploadedBy: map['uploadedBy'] ?? '',
    );
  }
}
