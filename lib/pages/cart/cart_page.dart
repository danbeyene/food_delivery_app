import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/app_routes.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: Dimensions.height30 * 2,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                ),
              ),
              SizedBox(
                width: Dimensions.width20 * 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.getInitial());
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                ),
              ),
              AppIcon(
                icon: Icons.shopping_cart,
                iconSize: Dimensions.iconSize24,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              )
            ],
          )),
      GetBuilder<CartController>(
        builder: (_cartController) {
          return _cartController.getItems.length>0? Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    List<CartModel> _cartList = cartController.getItems;
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _cartList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: Dimensions.height20 * 5,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    int popularProductIndex =
                                        Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(
                                                _cartList[index].productModel!);
                                    if (popularProductIndex >= 0) {
                                      Get.toNamed(AppRoutes.getPopularProduct(
                                          popularProductIndex,'cartPage'));
                                    } else {
                                      int recommendedProductIndex =
                                          Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                                  _cartList[index].productModel!);

                                      if(recommendedProductIndex<0){
                                        Get.snackbar('History product', 'product review is not available  for history products',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: AppColors.mainColor,
                                            colorText: Colors.white);
                                      }else{
                                        Get.toNamed(AppRoutes.getRecommendedProduct(
                                            recommendedProductIndex,'cartPage'));
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.width20 * 5,
                                    height: Dimensions.height20 * 5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOADS +
                                                    cartController
                                                        .getItems[index].img!))),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Expanded(
                                    child: Container(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: cartController.getItems[index].name!,
                                        textColor: Colors.black54,
                                      ),
                                      SmallText(text: 'Spicy'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text:
                                                '\$ ${cartController.getItems[index].price}',
                                            textColor: Colors.redAccent,
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.all(Dimensions.height10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.radius20),
                                                color: Colors.white),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartList[index]
                                                            .productModel!,
                                                        -1);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width5,
                                                ),
                                                BigText(
                                                    text: _cartList[index]
                                                        .productQuantity
                                                        .toString()), //'${popularProductController.itemsInCart}'),
                                                SizedBox(
                                                  width: Dimensions.width5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .productModel!,
                                                          1);
                                                    },
                                                    child: Icon(Icons.add,
                                                        color: AppColors.signColor))
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        });
                  }),
                ),
              )):NoDataPage(text: 'Your cart is empty!',);
        }
      ),
    ]),
      bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30,
                  top: Dimensions.height30),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: cartController.getItems.length>0?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        BigText(text: '\$ ${cartController.getTotalAmount}'),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(Get.find<AuthController>().userLoggedIn()){
                        cartController.addToHistory();
                      }else{
                       Get.toNamed(AppRoutes.getSignInPage());
                      }

                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: BigText(
                        text: 'Check Out',
                        textColor: Colors.white,
                        size: Dimensions.size16,
                      ),
                    ),
                  )
                ],
              ):Container(),
            );
          }),
    );
  }
}
