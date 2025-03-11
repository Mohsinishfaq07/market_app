class CarsSellModel {
  final String carCompanyName;
  final String productTitle;
  final String productCondition;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  final List<String> images;
  final String uploadedBy;

  CarsSellModel({
    required this.carCompanyName,
    required this.productTitle,
    required this.productCondition,
    required this.productDescription,
    required this.productLocation,
    required this.productPrice,
    required this.images,
    required this.uploadedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'carCompanyName': carCompanyName,
      'productTitle': productTitle,
      'productCondition': productCondition,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'productPrice': productPrice,
      'images': images,
      'uploadedBy': uploadedBy,
    };
  }

  factory CarsSellModel.fromMap(Map<String, dynamic> map) {
    return CarsSellModel(
      carCompanyName: map['carCompanyName'] ?? '',
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
