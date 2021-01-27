import 'dart:convert';

import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/model/cart_apparel_model.dart';
import 'package:filkop_mobile_apps/model/cart_product_model.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/model/category_apparel_model.dart';
import 'package:filkop_mobile_apps/model/delivery_response.dart';
import 'package:filkop_mobile_apps/model/detail_aparel_response.dart';
import 'package:filkop_mobile_apps/model/get_transaction_detail_result.dart';
import 'package:filkop_mobile_apps/model/get_transaction_response.dart';
import 'package:filkop_mobile_apps/model/get_transaction_result.dart';
import 'package:filkop_mobile_apps/model/get_user_result.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart' as Apparel;
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

  Future<Apparel.ApparelModel> getApparelModel(dynamic body) async {
    final response =
    await client.post("$baseUrl/restApi/get_apparel", body: body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return Apparel.ApparelModel.fromJson(parsed['data']);
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

  Future<CategoryApparelModel> getCategoryApparelModel() async {
    final response = await client.post('$baseUrl/restApi/get_category_apparel');
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        return CategoryApparelModel.fromJson(parsed['data']);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> addToCart(
      String productId, String total, String notes, String store) async {
    print("CALL FROM HERE");
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
    print("FNB IS");
    print(response.body);
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

  Future<bool> addToCartApparel(
      String productId, String total, String notes, String store, String size) async {
    SharedPreferences pref = await _prefs;
    final body = {
      'token': pref.getString('token'),
      'product_id': productId,
      'amount': total,

    };
    if(size != null){
      body['size'] = size;
    }


    final response =
    await client.post("$baseUrl/restApi/add_to_cart_apparel", body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        //refresh cart if success
        await client.post("$baseUrl/restApi/get_cart_apparel", body: body);
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

  Future<CartProductModel> getCart(String store) async {
    SharedPreferences pref = await _prefs;
    String location = pref.getString('location');
    final body = {'token': pref.getString('token'), 'store': store};

    final response =
        await client.post("$baseUrl/restApi/get_cart_fnb", body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        print("result success");
        print(parsed['data']);
        return CartProductModel.fromJson(parsed['data'], location);
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

  Future<CartApparelModel> getCartApparel(String store) async {
    SharedPreferences pref = await _prefs;
    String location = pref.getString('location');
    final body = {'token': pref.getString('token')};
    print(body);
    final response =
    await client.post("$baseUrl/restApi/get_cart_apparel", body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['success'] == true) {
        print("result success");
        print(parsed['data']);
        return CartApparelModel.fromJson(parsed['data'], location);
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
    print(response.body);
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

  Future<bool> deleteItemApparelFromCartApparel(String cartId) async {
    SharedPreferences pref = await _prefs;
    final body = {'token': pref.getString('token'), 'cart_id': cartId};

    final response =
    await client.post("$baseUrl/restApi/remove_cart_apparel", body: body);
    print(response.body);
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



  Future<bool> deleteItemFromCartApparel(String cartId) async {
    SharedPreferences pref = await _prefs;
    final body = {'token': pref.getString('token'), 'cart_id': cartId};

    final response =
    await client.post("$baseUrl/restApi/remove_cart_apparel", body: body);
    print(response.body);
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
    final body = {
      'store': store,
      'lat': latitude.toString(),
      'long': longitude.toString()
    };
    print(body);
    var response;
    try {
      response =
          await client.post("$baseUrl/restApi/gosend_fnb", body: body);
    } catch (_) {
      print("error try catch $_");
      return null;
    }
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        //check return api error or not
        if (parsed['errors'] == null) {

          //check is serviceable or not
          List<Gosend> retData = [];

          if (parsed['Instant']['serviceable'] == true) {
            try {
              retData.add(Gosend.fromJson(parsed['Instant']));
            }catch(_){
              print("error parsed from instant $_");
            }
          }
          print(parsed);
          if (parsed['SameDay']['serviceable'] == true) {
            try {
              retData.add(Gosend.fromJson(parsed['SameDay']));
            } catch (_) {
              print("error try from sameday $_");
            }
          }
          if (retData.length == 0) {
            retData = null;
          }

          print(retData);
          return retData;
        } else {
          print("response has error");
          return null;
        }
      } else {
        print("error status code");
        return null;
      }

  }

  Future<String> addTransactionFnb(
      String firstName,
      String lastName,
      String email,
      String phone,
      String addressId,
      String shipping,
      String shippingType,
      String shippingCost,
      String voucher,
      String latitude,
      String longitude,
      String store) async {

    SharedPreferences pref = await _prefs;

    final body = {
      'first_name': firstName,
      'last_name': lastName,
      'address_id' : addressId,
      'email': email,
      'phone' : phone,
      'shipping' : shipping,
      'shipping_type': shippingType,
      'shipping_cost' : shippingCost,
      'voucher' : voucher,
      'latitude' : latitude,
      'longitude' : longitude,
      'token' : pref.getString('token'),
      'store':store,
    };

    print("ADD REQUEST BODY");
    print(body);

    try {
      final response =
          await client.post("$baseUrl/restApi/proceed_fnb", body: body);
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        if(parsed['success'] == true){
          return 'success';
        }else{
          return parsed['msg'];
        }
      } else {
        return 'connection error';
      }
    }catch(_){
      return 'unexpected error ${_.toString()}';
    }
  }

  Future<String> addTransactionApparel(
      String firstName,
      String lastName,
      String email,
      String phone,
      String addressId,
      String shipping,
      String shippingType,
      String shippingCost,
      String voucher,
      String latitude,
      String longitude) async {

    SharedPreferences pref = await _prefs;

    final body = {
      'first_name': firstName,
      'last_name': lastName,
      'address_id' : addressId,
      'email': email,
      'phone' : phone,
      'shipping' : shipping,
      'shipping_type': shippingType,
      'shipping_cost' : shippingCost,
      'voucher' : voucher,
      'latitude' : latitude,
      'longitude' : longitude,
      'token' : pref.getString('token'),
    };

    print("ADD REQUEST BODY");
    print(body);

    try {
      final response =
      await client.post("$baseUrl/restApi/proceed", body: body);
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        if(parsed['success'] == true){
          return 'success';
        }else{
          return parsed['msg'];
        }
      } else {
        return 'connection error';
      }
    }catch(_){
      return 'unexpected error ${_.toString()}';
    }
  }

  Future<GetTransactionResult> getTransactionFnb() async {
    SharedPreferences pref = await _prefs;
    var body = {
      "token": pref.getString("token")
    };
    var response = await client.post("$baseUrl/restApi/get_transaction_fnb", body: body);
    if(response.statusCode == 200){
      return GetTransactionResult.fromJson(json.decode(response.body));
    }else{
      return null;
    }
  }
  Future<GetTransactionsResponse> getAllTransactions() async {
    SharedPreferences pref = await _prefs;
    var body = {
      "token": pref.getString("token")
    };
    var response = await client.post("$baseUrl/restApi/get_transaction", body: body);
    if(response.statusCode == 200){
      return GetTransactionsResponse.fromJson(json.decode(response.body));
    }else{
      return null;
    }
  }

  Future<GetTransactionResult> getTransactionApparel() async {
    SharedPreferences pref = await _prefs;
    var body = {
      "token": pref.getString("token")
    };
    var response = await client.post("$baseUrl/restApi/get_transaction", body: body);
    if(response.statusCode == 200){
      return GetTransactionResult.fromJson(json.decode(response.body),isApparel: true);
    }else{
      return null;
    }
  }


  Future<GetTransactionDetailResult> getTransactionDetail(String code,bool isApparel) async{
    var body = {
      "code" : code
    };
    var response;
    if(!isApparel) {
      response = await client.post("$baseUrl/restApi/get_detail_transaction_fnb", body: body);
    }else{
      response = await client.post("$baseUrl/restApi/get_detail_transaction", body: body);
    }

    if(response.statusCode == 200){
      return GetTransactionDetailResult.fromJson(json.decode(response.body));
    }else{
      return null;
    }
  }

  Future<bool> createPaymentIpay(String bankCode, String transactionCode)async{
    var body = {
      "code": transactionCode,
      "bank": bankCode
    };

    var response = await client.post("$baseUrl/restApi/create_ipay", body: body);
    print(response.body);
    return true;
  }

  Future<bool> createPaymentXendit(String bankCode, String transactionCode)async{
    var body = {
      "code": transactionCode,
      "bank": bankCode
    };

    var response = await client.post("$baseUrl/restApi/create_xendit", body: body);
    print(response.body);
    return true;
  }
  
  Future<bool> deletePayment(String transactionCode) async {
    var body = {
      "code": transactionCode
    };
    
    var response = await client.post("$baseUrl/restApi/delete_payment", body:body);
    print(response.body);
    return true;
  }

  Future<GetUserResult> getUser() async{
    SharedPreferences pref = await _prefs;
    var body = {
      "token": pref.getString("token")
    };
    var response = await client.post("$baseUrl/restApi/get_user", body: body);
    if(response.statusCode == 200) {
      return GetUserResult.fromJson(json.decode(response.body));
    }else{
      return null;
    }
  }

  Future<DetailApparelResponse> getDetailApparel(String id) async{
    var body = {
      "id":id
    };
    var response = await client.post("$baseUrl/restApi/get_detail_product",body: body);
    print(response.body);
    if(response.statusCode == 200){
      return DetailApparelResponse.fromJson(jsonDecode(response.body));
    }else{
      return null;
    }
  }

  Future<List<Result>> getAllDelivery(String destinationId, String weight) async {
    var body = {
      "subdistrict_id":destinationId,
      "weight":weight,
      "courier":"jne",
    };
    List<Result> retData = [];
    //fetch jne
    print(body);
    print("HERE");
    var response = await client.post("$baseUrl/restApi/cost",body: body);
    print("response body is");
    print("$baseUrl/restApi/cost");
    print(response.body);
    if(response.statusCode == 200){
     var deliveryResponse = DeliveryResponse.fromJson(jsonDecode(response.body));
     retData..addAll(deliveryResponse.rajaongkir.results);
    }
    //fetch jnt
    body['courier'] = "jnt";
    response = await client.post("$baseUrl/restApi/cost",body: body);
    print(response.body);
    if(response.statusCode == 200){
      var deliveryResponse2 = DeliveryResponse.fromJson(jsonDecode(response.body));
      retData..addAll(deliveryResponse2.rajaongkir.results);
    }

    return retData;
  }
}
