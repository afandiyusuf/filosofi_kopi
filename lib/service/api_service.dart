import 'dart:convert';

import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "https://filosofikopi.id";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Client client = Client();

  Future<BaseResponse> login(String email, String password) async {
    final requestBody = {'email': '$email', 'password': '$password'};
    final response =
        await client.post("$baseUrl/restApi/login", body: requestBody);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return BaseResponse.fromJsonSuccess(parsed);
      } else {
        return BaseResponse.fromJsonFail(parsed);
      }
    } else {
      return null;
    }
  }

  Future<StoreDatas> getStoreData() async {
    final response = await client.post("$baseUrl/restApi/get_store");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return StoreDatas.fromJson(parsed['data']);
    } else {
      return null;
    }
  }

  Future<int> checkLogin(dynamic body) async {
    final response = await client.post("$baseUrl/restApi/get_user", body: body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return 20;
    }
  }

  Future<ProductModel> getProductModelByStore(dynamic body) async {
    final response =
        await client.post("$baseUrl/restApi/get_menu_fnb", body: body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return ProductModel.fromJson(parsed['data']);
      } else {
        print(parsed);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<CategoryProductModel> getCategoryProductModel() async {
    final response = await client.post('$baseUrl/restApi/get_category_fnb');
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return CategoryProductModel.fromJson(parsed['data']);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> addToCart(String userId, String productId, String total,
      String notes, String store) async {
    SharedPreferences pref = await _prefs;
    final body = {
      'token': pref.getString('token'),
      'user_id': userId,
      'menu_id': productId,
      'qty': total,
      'notes': notes,
      'store': store
    };
    final response =
        await client.post("$baseUrl/restApi/add_to_cart_fnb", body: body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }
}
