import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  String appBaseUrl;
  late Map<String, String> _mainHeader ;
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    token= AppConstants.token;
    timeout = const Duration(seconds: 30);
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

}
