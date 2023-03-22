import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../widgets/account_widget.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          textColor: Colors.white,
          size: Dimensions.size10 * 3,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (!userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        ///profile icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height15 * 5,
                          backgroundSize: Dimensions.height15 * 10,
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ///name
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    backgroundSize: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.name
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                ///phone
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    backgroundSize: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.phone,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                ///email
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    backgroundSize: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.email,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                ///location
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.location_on,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    backgroundSize: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: 'Fill in your Address',
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                ///message
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.message_outlined,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    backgroundSize: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: 'Messages',
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                ///logout
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.offNamed(AppRoutes.getSignInPage());
                                    } else {
                                      print('you are logged out');
                                    }
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      backgroundSize: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: 'Logout',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : CustomLoader())
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*5,
                        margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/signintocontinue.png')
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20*5,
                          margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(child: BigText(text: 'Sign in',textColor: Colors.white,size: Dimensions.font30,)),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
