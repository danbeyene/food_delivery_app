import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../../widgets/small_text.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CartModel> getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    int listCounter = 0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat(
            'yyyy-MM-dd HH:mm:ss')
            .parse(
            getCartHistoryList[listCounter]
                .time!);
        var outputFormat =
        DateFormat('dd/mm/yyyy hh:mm a');
        outputDate =
            outputFormat.format(parseDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height20 * 5,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                    text: 'Your cart History',
                    textColor: Colors.white,
                    size: Dimensions.size10 * 3),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPerOrder.length; i++)
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height20),
                                  height: Dimensions.height10 * 12,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      width:
                                                          Dimensions.width20 *
                                                              4,
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                              .width5),
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOADS +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!)),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2)),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                          Container(
                                            height: Dimensions.height10 * 8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SmallText(
                                                  text: 'Total',
                                                  textColor:
                                                      AppColors.titleColor,
                                                ),
                                                // SizedBox(
                                                //   height: Dimensions.height10,
                                                // ),
                                                BigText(
                                                  text:
                                                      '${itemsPerOrder[i]} Items',
                                                  textColor:
                                                      AppColors.titleColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                // SizedBox(
                                                //   height: Dimensions.height10,
                                                // ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    //print('order time is ${orderTime.toString()}');
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        //print('my order time is ${orderTime[i]}');
                                                        print(
                                                            'the cart or product id is ${getCartHistoryList[j].id}');
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(AppRoutes
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .size10,
                                                            vertical: Dimensions
                                                                .size5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                3),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .mainColor,
                                                            width: 1)),
                                                    child: Center(
                                                      child: SmallText(
                                                        text: 'one more',
                                                        textColor:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          )),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: NoDataPage(
                      text: 'You didn\'t buy anything so far!',
                      imgPath: 'assets/image/empty_box.png',
                    ));
          })
        ],
      ),
    );
  }
}
