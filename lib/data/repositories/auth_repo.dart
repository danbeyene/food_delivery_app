import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> registration(SignUpBodyModel signUpBodyModel) async{
    return await apiClient.postData(AppConstants.RFGISTRATION_ENDPOINT, signUpBodyModel.toJson());
  }

 Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

 bool userLoggedIn()  {
    return  sharedPreferences.containsKey(AppConstants.TOKEN );
  }

  Future<Response> login(String phone, String password) async{
    return await apiClient.postData(AppConstants.LOGIN_ENDPOINT, {'phone':phone,'password':password});
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async{
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.updateHeader('');
    return true;
  }

}