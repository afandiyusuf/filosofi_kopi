import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class StoreDataRepository {
  final ApiService apiService;

  StoreDataRepository({
    @required this.apiService
  }) : assert(apiService != null);

  Future<StoreDatas> fetchStore() async{
    return await apiService.getStoreData();
  }
}