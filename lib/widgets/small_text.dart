import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/colors.dart';

class SmallText  extends StatelessWidget {
  SmallText({
    Key? key,
    this.textColor=AppColors.mainBlackColor,
    required this.text,
    this.size=12,
    this.height=1.2,
    this.maxLines,
    this.overFlow
  }) : super(key: key);
  Color? textColor;
  final String text;
  double size;
  double height;
  int? maxLines;
  TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: textColor,
          fontSize: size,
          height: height,
          fontFamily: 'Roboto',),
    );
  }
}
