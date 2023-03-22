import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/home/recommended_food_card.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

import '../../models/product_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_with_text.dart';
import '../../widgets/small_text.dart';
import 'package:get/get.dart';

class MainFoodBody extends StatefulWidget {
  const MainFoodBody({Key? key}) : super(key: key);

  @override
  State<MainFoodBody> createState() => _MainFoodBodyState();
}

class _MainFoodBodyState extends State<MainFoodBody> {
  PageController mainFoodController = PageController(viewportFraction: 0.85);
  double currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double heightMainFood = Dimensions.mainFoodPageViewContentHeight;
  @override
  void initState() {
    mainFoodController.addListener(() {
      setState(() {
        currentPageValue = mainFoodController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    mainFoodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///slider section
        GetBuilder<PopularProductController>(
            builder: (popularProductsController) {
          return popularProductsController.isLoaded == true
              ? Container(
            height: Dimensions.mainFoodPageViewHeight,
            child: PageView.builder(
                itemCount: popularProductsController.popularProductList.length,
                controller: mainFoodController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _buildFoodBody(
                      index,
                      popularProductsController
                          .popularProductList[index]);
                }),
          )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        ///dots
        GetBuilder<PopularProductController>(
            builder: (popularProductsController) {
          return DotsIndicator(
            dotsCount: popularProductsController.popularProductList.isEmpty
                ? 1
                : popularProductsController.popularProductList.length,
            position: currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),

        ///recommended text
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: BigText(
                  text: '.',
                  textColor: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height2),
                child: SmallText(text: 'Food Pairing'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),

        /// list of food and images
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProductController) {
          return recommendedProductController.isLoaded == true
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProductController
                          .recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return RecommendedFoodCard(
                        index: index,
                        productModel: recommendedProductController
                            .recommendedProductList[index]);
                  })
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildFoodBody(int index, ProductModel productModel) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      double currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      double currentTrans = heightMainFood * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      double currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      double currentTrans = heightMainFood * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      double currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      double currentTrans = heightMainFood * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      double currentScale = scaleFactor;
      double currentTrans = heightMainFood * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    }
    return Transform(
      transform: matrix4,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.getPopularProduct(index, 'homePage'));
        },
        child: Stack(
          children: [
            Container(
                height: Dimensions.mainFoodPageViewContentHeight,
                margin: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOADS +
                          productModel.img!),
                      fit: BoxFit.cover),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.mainFoodPageViewTextWidth,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: Dimensions.radius5,
                          offset: Offset(0, Dimensions.size5)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: Dimensions.radius5,
                          offset: Offset(Dimensions.size5, 0)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: Dimensions.radius5,
                          offset: Offset(-(Dimensions.size5), 0))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      top: Dimensions.height10),
                  child: AppColumn(
                    text: productModel.name!,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
