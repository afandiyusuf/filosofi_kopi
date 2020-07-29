import 'package:filkop_mobile_apps/config.dart';
import 'package:flutter/material.dart';
class StoreDatas extends ChangeNotifier {
  List<Store> stores;
  StoreDatas({this.stores});

  factory StoreDatas.fromJson(data){
    return StoreDatas(
      stores: List<Store>.from(data.map((item)=> Store.fromJson(item)))
    );
  }

  List<Store> getStoreDatas(){
    return stores;
  }
  int getTotalStore(){
    return stores.length;
  }
  Store getStoreById(int id){
    return stores.firstWhere((storeData) => storeData.id == id);
  }
  Store getStoreByIndex(int index){
    return stores[index];
  }
}
class Store{
  final String name;
  final String location;
  final int id;
  final String image;
  const Store({this.id, this.name,this.location , this.image});

  factory Store.fromJson(Map<String, dynamic> map){
    return Store(
        name: map['name'],
        location: map['link'],
        id: int.parse(map['id']),
        image: storeImageBaseUrl+map['photo_1']
    );
  }
}