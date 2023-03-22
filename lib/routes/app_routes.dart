import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class AppRoutes {
  static const String splashPage = '/splash-page';
  static const String initial = '/';
  static const String popularProduct = '/popular-food';
  static const String recommendedProduct = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularProduct(int pageId, String page) => '$popularProduct?pageId=$pageId&page=$page';
  static String getRecommendedProduct(int pageId, String page) => '$recommendedProduct?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';

  static List<GetPage> pages = [
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularProduct,
        page: () {
          var pageId= Get.parameters['pageId'];
          var page= Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn,),
    GetPage(
        name: recommendedProduct,
        page: () {
          var pageId= Get.parameters['pageId'];
          var page= Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn,),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
  transition: Transition.fadeIn
    ),
    GetPage(name: signIn, page: (){
      return SignInPage();
    },
        transition: Transition.fade
    )
  ];
}
