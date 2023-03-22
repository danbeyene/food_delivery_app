import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/app_routes.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    _loadResources();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
        ()=>Get.offNamed(AppRoutes.getInitial())
        //     ()=>Get.offNamed(AppRoutes.getSignInPage())
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _loadResources()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset('assets/image/logo part 1.png', width: Dimensions.splashImg,))),
          Center(child: Image.asset('assets/image/logo part 2.png', width: Dimensions.splashImg,))
        ],
      ),
    );
  }
}
