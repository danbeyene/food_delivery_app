import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';
class RecommendedProductRepo extends GetxService{
  ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async{
    Response response = await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_ENDPOINT);
    return response;
  }
}