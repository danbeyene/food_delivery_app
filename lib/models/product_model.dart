class Products {
  int? _total_size;
  int? _type_id;
  int? _offset;
  late List<ProductModel> _productList;
  List<ProductModel> get productList => _productList;
  Products(
      {required total_size,
      required type_id,
      required offset,
      required product}) {
    this._total_size = total_size;
    this._type_id = type_id;
    this._offset = offset;
    this._productList = product;
  }
  Products.fromJson(Map<String, dynamic> json) {
    _total_size = json['total_size'];
    _type_id = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _productList = <ProductModel>[];
      for (var element in json['products']) {
        _productList.add(ProductModel.fromJson(element));
      }
    }
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  int? type_id;
  ProductModel({this.id, this.name, this.description, this.price, this.stars, this.img, this.location, this.type_id});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    type_id = json['type_id'];
  }
}
