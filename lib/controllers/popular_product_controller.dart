import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repositories/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  late CartController _cartController;
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _productQuantity = 0;
  int get productQuantity => _productQuantity;

  int _itemsInCart = 0;
  int get itemsInCart => _itemsInCart + _productQuantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // print('got popular products');
      _popularProductList = [];
      _popularProductList.addAll(Products.fromJson(response.body).productList);
      // _popularProductList.shuffle();
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement == true) {
      _productQuantity = checkProductQuantity(_productQuantity + 1);
      //print('increment ${_productQuantity}');
    } else if (isIncrement == false) {
      _productQuantity = checkProductQuantity(_productQuantity - 1);
      //print('decrement ${_productQuantity}');
    }
    update();
  }

  int checkProductQuantity(int localQuantity) {
    if ((_itemsInCart+localQuantity) < 0) {
      Get.snackbar('Cart Quantity', 'you should at least add 1 item',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      if(_itemsInCart>0){
        _productQuantity=-_itemsInCart;
        return _productQuantity;
      }
      return 0;
    } else if ((_itemsInCart+localQuantity) > 20) {
      Get.snackbar('Cart Quantity', 'you can not add more than 10 items',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      return 20;
    } else {
      return localQuantity;
    }
  }

  initProductQuantity(ProductModel productModel,CartController cartController) {
    _productQuantity = 0;
    _itemsInCart = 0;
    _cartController = cartController;
    bool exist=false;
    exist = _cartController.existItem(productModel);
    //print('is item exist already ----- ${exist}');
    if(exist){
      _itemsInCart=_cartController.getQuantity(productModel);
    }
    //print('the quantity in the cart ----- ${_itemsInCart.toString()}');
  }

  addItem(ProductModel productModel) {
      _cartController.addItem(productModel, _productQuantity);
      _productQuantity=0;
      _itemsInCart=_cartController.getQuantity(productModel);

      _cartController.items.forEach((key, value) {
        print(
            'product- ID = ${value.id}, quantity = ${value.productQuantity}');
      });
    update();
  }

  int get totalItems{
    return _cartController.totalItems;
  }
  List<CartModel> get getItems{
    return _cartController.getItems;
  }

}
