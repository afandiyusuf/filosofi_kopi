import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:flutter/cupertino.dart';

class StoreProvider extends ChangeNotifier{
  Store store;

  void updateStore(Store store){
    this.store = store;
    notifyListeners();
  }
}