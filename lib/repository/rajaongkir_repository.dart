import 'package:filkop_mobile_apps/model/province_model.dart';
import 'package:filkop_mobile_apps/service/rajaongkir_service.dart';
import 'package:flutter/cupertino.dart';

class RajaOngkirRepository {
  final RajaOngkirService rajaOngkirService;

  RajaOngkirRepository({
    @required this.rajaOngkirService
  }) : assert(rajaOngkirService != null);

  Future<List<Province>> fetchProvince() async{
    return await rajaOngkirService.getProvince();
  }
}