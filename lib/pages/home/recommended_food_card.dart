import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../../models/product_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/icon_with_text.dart';
import '../food/popular_food_detail.dart';
import 'package:get/get.dart';

class RecommendedFoodCard extends StatelessWidget {
  RecommendedFoodCard({Key? key, required this.index,required this.productModel}) : super(key: key);
  int index;
  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.getRecommendedProduct(index));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: Dimensions.height10),
        child: Row(
          children: [
            ///image section
            Container(
              height: Dimensions.listViewImgSize,
              width: Dimensions.listViewImgSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white38,
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.appBaseUrl +
                          AppConstants.uploads +
                          productModel.img!),
                      fit: BoxFit.cover)),
            ),

            ///text section
            Expanded(
                child: Container(
                  height: Dimensions.listViewTextContSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10, right: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(text: productModel.name!),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        SmallText(text: productModel.description!,maxLines: 1,overFlow: TextOverflow.ellipsis,),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconWithTextWidget(
                              text: 'normal',
                              iconData: Icons.circle_sharp,
                              color: AppColors.iconColor1,
                            ),
                            IconWithTextWidget(
                              text: '1.7km',
                              iconData: Icons.location_on,
                              color: AppColors.mainColor,
                            ),
                            IconWithTextWidget(
                              text: '32min',
                              iconData: Icons.access_time_rounded,
                              color: AppColors.iconColor2,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
