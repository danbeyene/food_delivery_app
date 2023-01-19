import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class BigText extends StatelessWidget {
  BigText({
    Key? key,
    this.textColor = AppColors.mainBlackColor,
    required this.text,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
    this.fontWeight= FontWeight.w400
  }) : super(key: key);
  Color? textColor;
  final String text;
  double size;
  TextOverflow overFlow;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
          color: textColor,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontWeight: fontWeight,
          fontFamily: 'Roboto'),
    );
  }
}
