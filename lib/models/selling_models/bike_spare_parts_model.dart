class BikeSparePartsModel {
  final String sparePartType;

  final String productTitle;
  final String productCondition;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  final List<String> images;
  final String uploadedBy;

  BikeSparePartsModel({
    required this.productTitle,
    required this.productCondition,
    required this.productDescription,
    required this.productLocation,
    required this.productPrice,
    required this.images,
    required this.uploadedBy,
    required this.sparePartType,
  });

  Map<String, dynamic> toMap() {
    return {
      'productTitle': productTitle,
      'productCondition': productCondition,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'productPrice': productPrice,
      'images': images,
      'uploadedBy': uploadedBy,
      'sparePartType': sparePartType
    };
  }

  factory BikeSparePartsModel.fromMap(Map<String, dynamic> map) {
    return BikeSparePartsModel(
      sparePartType: map['sparePartType'] ?? '',
      productTitle: map['productTitle'] ?? '',
      productCondition: map['productCondition'] ?? '',
      productDescription: map['productDescription'] ?? '',
      productLocation: map['productLocation'] ?? '',
      productPrice: map['productPrice'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      uploadedBy: map['uploadedBy'] ?? '',
    );
  }
}
