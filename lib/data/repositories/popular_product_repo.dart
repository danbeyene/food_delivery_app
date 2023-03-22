import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async{
    Response response = await apiClient.getData(AppConstants.POPULAR_PRODUCT_ENDPOINT);
    return response;
  }
}