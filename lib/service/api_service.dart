import 'dart:convert';

import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/model/cart_model.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
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
        SharedPreferences pref = await _prefs;
        BaseResponse baseResponse = BaseResponse.fromJsonSuccess(parsed);
        pref.setString('token', baseResponse.data.token);
        return baseResponse;
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

  Future<bool> addToCart(
      String productId, String total, String notes, String store) async {
    SharedPreferences pref = await _prefs;
    final body = {
      'token': pref.getString('token'),
      'menu_id': productId,
      'qty': total,
      'notes': notes,
      'store': store
    };

    print(body);

    final response =
        await client.post("$baseUrl/restApi/add_to_cart_fnb", body: body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        //refresh cart if success
        await client.post("$baseUrl/restApi/get_cart_fnb", body: body);
        return true;
      } else {
        print(response.body);
        return false;
      }
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<CartModel> getCart(String store) async {
    SharedPreferences pref = await _prefs;
    String location = pref.getString('location');
    final body = {'token': pref.getString('token'), 'store': store};

    final response =
        await client.post("$baseUrl/restApi/get_cart_fnb", body: body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        print("result success");
        print(parsed['data']);
        return CartModel.fromJson(parsed['data'], location);
      } else {
        print(response.body);
        return null;
      }
    } else {
      print(response.statusCode);
      print(response.body);
      return null;
    }
  }

  Future<bool> deleteItemFromCart(String cartId) async {
    SharedPreferences pref = await _prefs;
    final body = {'token': pref.getString('token'), 'cart_id': cartId};

    final response =
        await client.post("$baseUrl/restApi/remove_cart_fnb", body: body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<String> register(
      String username,
      String email,
      String password,
      String dob,
      String gender,
      String province,
      String city,
      String phone,
      String pin) async {
    final body = {
      'username': username,
      'email': email,
      'password': password,
      'dob': dob,
      'gender': gender,
      'province': province,
      'city': city,
      'phone': phone,
      'pin': pin
    };
    final response = await client.post("$baseUrl/restApi/register", body: body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success']) {
        return 'success';
      } else {
        return parsed['msg'];
      }
    } else {
      return 'error';
    }
  }

  Future<List<Gosend>> getGosendService(
      String store, double latitude, double longitude) async {
    final body = {'store': store, 'lat': latitude.toString(), 'long': longitude.toString()};
    final response = await client.post("$baseUrl/restApi/gosend_fnb", body: body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      List<Gosend> retData = [];
      try {
        retData.add(Gosend.fromJson(parsed['Instant']));
      } catch (_) {}

      try {
        retData.add(Gosend.fromJson(parsed['SameDay']));
      } catch (_) {}

      return retData;
    } else {
      return null;
    }
  }
}
