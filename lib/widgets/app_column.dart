import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_with_text.dart';

class AppColumn extends StatelessWidget {
   AppColumn({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          fontWeight: FontWeight.w500,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimensions.size15,
                  )),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: '4.5',
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: '1287'),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: 'comments')
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
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
        ),
      ],
    );
  }
}
