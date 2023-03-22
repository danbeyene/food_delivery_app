import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/icon_with_text.dart';
import '../../widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel popularProductModel =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProductQuantity(popularProductModel, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ///background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.height350,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOADS +
                            popularProductModel.img!),
                        fit: BoxFit.cover)),
              )),

          ///icons
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.closeAllSnackbars();
                      if(page=='cartPage'){
                        Get.toNamed(AppRoutes.getCartPage());
                      }else{
                        Get.toNamed(AppRoutes.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconSize: Dimensions.size16,
                    ),
                  ),
                  GetBuilder<PopularProductController>(
                      builder: (popularProductController) {
                    return GestureDetector(
                      onTap: (){
                        if(popularProductController.totalItems >= 1) {
                          Get.toNamed(AppRoutes.cartPage);
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconSize: Dimensions.size16,
                          ),
                          popularProductController.totalItems >= 1
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                    backgroundSize:
                                        popularProductController.totalItems >= 9
                                            ? Dimensions.size5 * 5
                                            : Dimensions.size5 * 4,
                                  ),
                                )
                              : Container(),
                          popularProductController.totalItems >= 1
                              ? Positioned(
                                  top: 3,
                                  right: 3,
                                  child: BigText(
                                    text: popularProductController.totalItems
                                        .toString(),
                                    size: Dimensions.size15,
                                    textColor: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              )),

          ///introduction of food
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: Dimensions.height330,
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                height: Dimensions.height500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius30),
                        topRight: Radius.circular(Dimensions.radius30)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: popularProductModel.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: 'Introduce'),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                      text: popularProductModel.description!,
                    )))
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProductController) {
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
          child: Row(
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
                    GestureDetector(
                      onTap: () {
                        popularProductController.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    BigText(text: '${popularProductController.itemsInCart}'),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    GestureDetector(
                        onTap: () {
                          popularProductController.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProductController.addItem(popularProductModel);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                  child: Row(
                    children: [
                      BigText(
                        text: '\$ ${popularProductModel.price}',
                        textColor: Colors.white,
                        size: Dimensions.size16,
                      ),
                      SizedBox(
                        width: Dimensions.width5,
                      ),
                      BigText(
                        text: 'Add to cart',
                        textColor: Colors.white,
                        size: Dimensions.size16,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
