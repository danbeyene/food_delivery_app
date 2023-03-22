import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../widgets/app_text_field.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  void _login(AuthController authController) {
    // AuthController authController= Get.find<AuthController>();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackBar('Type in your phone number', title: 'Phone number');
    }else if (password.isEmpty) {
      showCustomSnackBar('Type in your password', title: 'Password');
    } else if (password.length < 6) {
      showCustomSnackBar('Password can not be less than six characters',
          title: 'Password');
    } else {

      authController.login(phone, password).then((status) {
        if(status.isSuccess){
          showCustomSnackBar('All went well', title: 'Perfect', isError: false);
          print('succes registration');
          Get.toNamed(AppRoutes.getInitial());
        }else{
          showCustomSnackBar(status.message);
        }
      });
      //print(signupBody.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading?SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight * 0.01,
                ),

                ///app logo
                Container(
                  height: Dimensions.screenHeight * 0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.height20 * 4,
                      backgroundImage: AssetImage('assets/image/logo part 1.png'),
                    ),
                  ),
                ),

                ///welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize:
                                Dimensions.font30 * 2 + (Dimensions.font20 / 2),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign into your account',
                        style: TextStyle(
                            fontSize: Dimensions.font20, color: Colors.grey[500]),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                ///phone
                AppTextField(
                  textEditingController: phoneController,
                  hintText: 'Phone',
                  iconData: Icons.phone,
                ),
                SizedBox(
                  height: Dimensions.height20 * 2,
                ),

                ///password
                AppTextField(
                  isObscure: true,
                  textEditingController: passwordController,
                  hintText: 'Password',
                  iconData: Icons.password_sharp,
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),

                ///tagline
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                        text: TextSpan(
                            text: 'Sign into your account',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20))),
                    SizedBox(
                      width: Dimensions.width20,
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),

                ///sign in button
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    height: Dimensions.screenHeight / 13,
                    width: Dimensions.screenWidth / 3,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius30)),
                    child: Center(
                        child: BigText(
                      text: 'Sign In',
                      textColor: Colors.white,
                      size: Dimensions.size10 * 3,
                    )),
                  ),
                ),

                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),

                ///create account
                RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20),
                      children: [
                        TextSpan(
                            text: ' Create',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get
                                ..to(() => SignUpPage(),
                                    transition: Transition.fade),
                            style: TextStyle(
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              ],
            ),
          ):const CustomLoader();
        }
      ),
    );
  }
}
