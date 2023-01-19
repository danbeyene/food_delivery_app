import 'package:get/get.dart';

import '../data/repositories/recommended_product_repo.dart';
import '../models/product_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded=> _isLoaded;
  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){
      print('got recommended products');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Products.fromJson(response.body).productList);
      _isLoaded=true;
      update();
    }
  }
}