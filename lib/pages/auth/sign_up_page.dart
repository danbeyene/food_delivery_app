import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

import '../../routes/app_routes.dart';
import '../../widgets/app_text_field.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> signupImages = ['g.png', 't.png', 'f.png'];

  void _registration(AuthController authController) {
    // AuthController authController= Get.find<AuthController>();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (name.isEmpty) {
      showCustomSnackBar('Type in your name', title: 'Name');
    } else if (phone.isEmpty) {
      showCustomSnackBar('Type in your phone number', title: 'Phone number');
    } else if (email.isEmpty) {
      showCustomSnackBar('Type in your email address',
          title: 'Email address');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('Type in a valid email address',
          title: 'Valid email address');
    } else if (password.isEmpty) {
      showCustomSnackBar('Type in your password', title: 'Password');
    } else if (password.length < 6) {
      showCustomSnackBar('Password can not be less than six characters',
          title: 'Password');
    } else {
      // showCustomSnackBar('All went well', title: 'Perfect', isError: false);
      SignUpBodyModel signupBody = SignUpBodyModel(
          name: name, phone: phone, email: email, password: password);
      authController.registration(signupBody).then((status) {
        if(status.isSuccess){
          showCustomSnackBar('All went well', title: 'Perfect', isError: false);
          print('succes registration');
          Get.offNamed(AppRoutes.getInitial());
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

                ///email
                AppTextField(
                  textEditingController: emailController,
                  hintText: 'Email',
                  iconData: Icons.email,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                ///password
                AppTextField(
                  isObscure: true,
                  textEditingController: passwordController,
                  hintText: 'Password',
                  iconData: Icons.password_sharp,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                ///Name
                AppTextField(
                  textEditingController: nameController,
                  hintText: 'Name',
                  iconData: Icons.person,
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

                ///sign up button
                GestureDetector(
                  onTap: () {
                    _registration(authController);
                  },
                  child: Container(
                    height: Dimensions.screenHeight / 13,
                    width: Dimensions.screenWidth / 3,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius30)),
                    child: Center(
                        child: BigText(
                      text: 'Sign Up',
                      textColor: Colors.white,
                      size: Dimensions.size10 * 3,
                    )),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),

                ///tagline
                RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: 'Have an account already?',
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: Dimensions.font20))),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),

                ///sign up option
                RichText(
                    text: TextSpan(
                        text: 'Sign up using one of the following method',
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: Dimensions.font16))),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Wrap(
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: EdgeInsets.all(Dimensions.size16 / 2),
                            child: CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage:
                                  AssetImage('assets/image/${signupImages[index]}'),
                            ),
                          )),
                )
              ],
            ),
          ):const CustomLoader();
        }
      ),
    );
  }
}
