import 'package:filkop_mobile_apps/model/city_model.dart';
import 'package:filkop_mobile_apps/model/subdistrict.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:filkop_mobile_apps/model/province_model.dart';

class RajaOngkirService {
  Client client = Client();
  String key = 'a607a4d120de45a7febff4cf02bddf7d';
  String baseUrl = 'https://pro.rajaongkir.com/api';

  Future<List<Province>> getProvince() async {
    final response =
        await client.get('$baseUrl/province', headers: {'key': key});
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed['rajaongkir']['status']['code'] == 200) {
        final data = parsed['rajaongkir']['results'];
        return List<Province>.from(data.map((item) {
          return Province.fromJson(item);
        }));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<City>> getCities(String provinceId) async {
    final response = await client
        .get('$baseUrl/city?province=$provinceId', headers: {'key': key});
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);
      if (parsed['rajaongkir']['status']['code'] == 200) {
        final data = parsed['rajaongkir']['results'];
        return List<City>.from(data.map((item) {
          return City.fromJson(item);
        }));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<Subdistrict>> getSubdistrict(String cityId) async {
    final response = await client
        .get('$baseUrl/subdistrict?city=$cityId', headers: {'key': key});
    print('$baseUrl/subdistrict?city=$cityId');
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      if (parsed['rajaongkir']['status']['code'] == 200) {
        final data = parsed['rajaongkir']['results'];
        print("DATA IS");
        print(data);
        return List<Subdistrict>.from(data.map((item) {
          return Subdistrict.fromJson(item);
        }));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

}
