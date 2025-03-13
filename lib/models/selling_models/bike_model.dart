class BikeSellModel {
  final String bikeCompanyName;
  final String productTitle;

  final String productDescription;
  final String productLocation;
  final String productPrice;
  final List<String> images;
  final String uploadedBy;

  BikeSellModel({
    required this.bikeCompanyName,
    required this.productTitle,
    required this.productDescription,
    required this.productLocation,
    required this.productPrice,
    required this.images,
    required this.uploadedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'bikeCompanyName': bikeCompanyName,
      'productTitle': productTitle,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'productPrice': productPrice,
      'images': images,
      'uploadedBy': uploadedBy,
    };
  }

  factory BikeSellModel.fromMap(Map<String, dynamic> map) {
    return BikeSellModel(
      bikeCompanyName: map['bikeCompanyName'] ?? '',
      productTitle: map['productTitle'] ?? '',
      productDescription: map['productDescription'] ?? '',
      productLocation: map['productLocation'] ?? '',
      productPrice: map['productPrice'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      uploadedBy: map['uploadedBy'] ?? '',
    );
  }
}
