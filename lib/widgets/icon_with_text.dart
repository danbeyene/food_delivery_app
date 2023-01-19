import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../utils/dimensions.dart';
class IconWithTextWidget extends StatelessWidget {
   IconWithTextWidget({Key? key,this.iconData,this.text,this.color}) : super(key: key);
  IconData? iconData;
  String? text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData,color: color,),
        SizedBox(width: Dimensions.width5,),
        SmallText(text: text!,)
      ],
    );
  }
}
