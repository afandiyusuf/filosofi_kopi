import 'dart:convert';

import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "https://filosofikopi.id";
  Client client = Client();
  
  Future<String> login(String email, String password) async {

    final requestBody = {
      'email': '$email',
      'password': '$password'
    };

    final response = await client.post("$baseUrl/restApi/login",
    body: requestBody);

    if(response.statusCode == 200){
      final parsed = json.decode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(parsed);
      return baseResponse.msg;
    }else{
      return null;
    }
  }
  Future<StoreDatas> getStoreData() async {
    final response = await client.post("$baseUrl/restApi/get_store");

    if(response.statusCode == 200){
      final parsed = json.decode(response.body);
      return StoreDatas.fromJson(parsed['data']);
    }else{
      return null;
    }
  }

}