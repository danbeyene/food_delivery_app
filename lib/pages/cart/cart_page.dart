import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

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
                onTap:(){
                },
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
                onTap: (){
                  Get.to(()=>MainFoodPage());
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
      Positioned(
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
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cartController.getItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: Dimensions.height20 * 5,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.width20 * 5,
                              height: Dimensions.height20 * 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.appBaseUrl +
                                              AppConstants.uploads +
                                              cartController
                                                  .getItems[index].img!))),
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
                                                //popularProductController.setQuantity(false);
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
                                                text:
                                                    '0'), //'${popularProductController.itemsInCart}'),
                                            SizedBox(
                                              width: Dimensions.width5,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  //popularProductController.setQuantity(true);
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
          )),
    ]));
  }
}
