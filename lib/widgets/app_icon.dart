import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.backgroundSize = 40,
      this.iconSize})
      : super(key: key);
  IconData icon;
  Color? backgroundColor;
  Color? iconColor;
  double? backgroundSize;
  double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: backgroundSize,
      width: backgroundSize,
      // padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(backgroundSize! / 2),
        color: backgroundColor,
      ),
      child: Icon(icon,color: iconColor,size: iconSize,),
    );
  }
}
