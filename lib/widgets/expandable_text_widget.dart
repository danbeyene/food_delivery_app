import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  ExpandableTextWidget({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimensions.height150;
  @override
  void initState() {
    if (widget.text.length > textHeight.toInt()) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(
                text: firstHalf,
                size: Dimensions.size15,
                textColor: AppColors.paraColor,
                height: Dimensions.height3/2,
              )
            : Column(
                children: [
                  SmallText(
                    text: hiddenText == true
                        ? '$firstHalf...'
                        : firstHalf + secondHalf,
                    size: Dimensions.size15,
                    textColor: AppColors.paraColor,
                    height: Dimensions.height3/2,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: hiddenText == true ? 'Show more' : 'Show less',
                          textColor: AppColors.mainColor,
                          size: Dimensions.size15,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        Icon(
                          hiddenText == true
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
