import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel productModel, int quantity) {
    //print('Cart Item length- ${_items.length.toString()}');
    int totalQuantity=0;
    if (_items.containsKey(productModel.id)) {
      _items.update(productModel.id!, (value) {
         totalQuantity = value.productQuantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            productQuantity: value.productQuantity! + quantity,
            isExist: true,
            time: DateTime.now().toString());
      });
      if(totalQuantity <= 0){
        _items.remove(productModel.id);
      }
    } else {
      if(quantity>0){
        _items.putIfAbsent(productModel.id!, () {

          return CartModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              productQuantity: quantity,
              isExist: true,
              time: DateTime.now().toString());
        });
      }else{
        Get.snackbar('Cart Quantity', 'You should add at least one item',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
      }
    }
  }
  bool existItem(ProductModel productModel){
    if(_items.containsKey(productModel.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productModel){
    int quantity=0;
    if(_items.containsKey(productModel.id)){
      _items.forEach((key, value) {
        if(key==productModel.id){
          quantity = value.productQuantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.productQuantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();

  }

}
