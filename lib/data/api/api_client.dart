import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product_model.dart';
import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  String appBaseUrl;
  late Map<String, String> _mainHeaders ;
  late SharedPreferences sharedPreferences;
  ApiClient({required this.appBaseUrl,required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    token= sharedPreferences.getString(AppConstants.TOKEN)??'';
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      "Connection": "Keep-Alive",
      'Authorization':'Bearer $token'
    };
  }

  updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      "Connection": "Keep-Alive",
      'Authorization':'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String,String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String uri,dynamic body) async {
  print(body.toString());
    try{
      Response response= await post(uri, body,headers: _mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
      print(e.toString());
    }

  }

}
