import 'package:food_delivery_app/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? productQuantity;
  bool? isExist;
  String? time;
  ProductModel? productModel;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.productQuantity,
      this.isExist,
      this.time,
      this.productModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    productQuantity = json['productQuantity'];
    isExist = json['isExist'];
    time = json['time'];
    productModel = ProductModel.fromJson(json['productModel']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'img': this.img,
      'productQuantity': this.productQuantity,
      'isExist': this.isExist,
      'time': this.time,
      "productModel": this.productModel!.toJson()
  };
  }
}
