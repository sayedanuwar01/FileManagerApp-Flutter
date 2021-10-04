

class PackageModel {

  String userId;
  String info;
  String name;
  String description;
  String price;
  String expiryDate;
  String purchaseDate;

  PackageModel({this.userId, this.info = '', this.name = '', this.description = '', this.price = '', this.expiryDate = '', this.purchaseDate = ''});

  factory PackageModel.fromJson(Map<dynamic, dynamic> json) {
    return PackageModel(
      userId : json['userId'] as String,
      info : json['info'] as String,
      name : json['name'] as String,
      description : json['description'] as String,
      price : json['price'] as String,
      expiryDate : json['expiryDate'] as String,
      purchaseDate : json['purchaseDate'] as String,
    );
  }

}