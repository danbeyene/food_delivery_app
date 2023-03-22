import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';
import 'package:get/get.dart';

import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel  recommendedProductModel= Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<RecommendedProductController>().initProductQuantity(recommendedProductModel,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
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
                    }, child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<RecommendedProductController>(
                    builder: (recommendedProductController) {
                      return GestureDetector(
                        onTap: (){
                          if(recommendedProductController.totalItems>=1) {
                            Get.toNamed(AppRoutes.cartPage);
                          }
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            recommendedProductController.totalItems>=1?Positioned(
                              top:0,
                              right:0,
                              child: AppIcon(
                                icon: Icons.circle,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                                backgroundSize: recommendedProductController.totalItems >= 9
                                    ? Dimensions.size5 * 5
                                    : Dimensions.size5 * 4,
                              ),
                            ):Container(),
                            recommendedProductController.totalItems >= 1
                                ? Positioned(
                              top: 3,
                              right: 3,
                              child: BigText(
                                text: recommendedProductController.totalItems
                                    .toString(),
                                size: Dimensions.size15,
                                textColor: Colors.white,
                              ),
                            )
                                : Container()
                          ],
                        ),
                      );
                    }
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30),
                    ),
                    color: Colors.white),
                child: Center(
                    child: BigText(
                  text: recommendedProductModel.name!,
                  size: Dimensions.font20,
                )),
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOADS +
                      recommendedProductModel.img!,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(
                      text:
                      recommendedProductModel.description!
                )
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<RecommendedProductController>(
        builder: (recommendedProductController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width5 * 10,
                    right: Dimensions.width5 * 10,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        recommendedProductController.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    BigText(text: '\$ ${recommendedProductModel.price} ' + ' x ' + ' ${recommendedProductController.itemsInCart}'),
                    GestureDetector(
                      onTap: () {
                        recommendedProductController.setQuantity(true);
                      },
                      child: AppIcon(
                          icon: Icons.add,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.iconSize24),
                    )
                  ],
                ),
              ),
              Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        recommendedProductController.addItem(recommendedProductModel);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.height20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: Row(
                          children: [
                            BigText(
                              text: '\$ ${recommendedProductModel.price}',
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
              )
            ],
          );
        }
      ),
    );
  }
}
