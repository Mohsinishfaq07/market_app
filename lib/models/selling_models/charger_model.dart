class AccessoryChargerModel {
  final String chargerForDevice;
  final String chargerType;
  final String productCondition;
  final String productTitle;
  final String productDescription;
  final String productLocation;
  final String productPrice;
  final List<String> images;
  final String uploadedBy;

  AccessoryChargerModel({
    required this.chargerForDevice,
    required this.chargerType,
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
      'chargerForDevice': chargerForDevice,
      'chargerType': chargerType,
      'productCondition': productCondition,
      'productTitle': productTitle,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'productPrice': productPrice,
      'images': images,
      'uploadedBy': uploadedBy,
    };
  }

  factory AccessoryChargerModel.fromMap(Map<String, dynamic> map) {
    return AccessoryChargerModel(
      chargerForDevice: map['chargerForDevice'] ?? '',
      chargerType: map['chargerType'] ?? '',
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
