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
  List<CartModel> storageItems=[];

  void addItem(ProductModel productModel, int quantity) {
    //print('Cart Item length- ${_items.length.toString()}');
    int totalQuantity = 0;
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
            time: DateTime.now().toString(),
            productModel: productModel);
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              productQuantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              productModel: productModel);
        });
      } else {
        Get.snackbar('Cart Quantity', 'You should add at least one item',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existItem(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productModel) {
    int quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.productQuantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.productQuantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get getTotalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.productQuantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    //print('the length of cart item is  ${storageItems.length}');
    for(int i=0; i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].productModel!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistory();
    clear();
  }

  void clear() {
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int,CartModel> setItems){
    _items={};
    _items=setItems;
  }
  
  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }


}
