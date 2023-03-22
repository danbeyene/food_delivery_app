import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/dimensions.dart';
import 'main_food_body.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: Column(
      children: [
        ///show header
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Ethiopia',
                      textColor: AppColors.mainColor,
                      size: Dimensions.font30,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: 'Addis Ababa',
                          textColor: Colors.black54,
                        ),
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  height: Dimensions.height45,
                  width: Dimensions.width45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: Dimensions.iconSize24,
                  ),
                )
              ],
            ),
          ),
        ),

        ///show food body
        Expanded(
            child: SingleChildScrollView(
              child: MainFoodBody(),
            )),
      ],
    ), onRefresh: _loadResources);
  }
}

