import 'package:flutter/cupertino.dart';

class SignUpBodyModel {
  String name;
  String phone;
  String email;
  String password;
  SignUpBodyModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data =<String,dynamic>{};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;

    return data;
  }

}
