import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initial = '/';
  static const String popularProduct = '/popular-food';
  static const String recommendedProduct = '/recommended-food';

  static String getInitial() => '$initial';
  static String getPopularProduct(int pageId) => '$popularProduct?pageId=$pageId';
  static String getRecommendedProduct(int pageId) => '$recommendedProduct?pageId=$pageId';

  static List<GetPage> pages = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularProduct,
        page: () {
          var pageId= Get.parameters['pageId'];
          return PopularFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn,),
    GetPage(
        name: recommendedProduct,
        page: () {
          var pageId= Get.parameters['pageId'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn,),
  ];
}
