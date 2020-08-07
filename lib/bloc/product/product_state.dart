import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ProductState extends Equatable{
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductEmpty extends ProductState{}
class ProductDataLoading extends ProductState{}
class ProductDataLoaded extends ProductState{
  final ProductModel products;

  @override
  List<Object> get props => [products];
  const ProductDataLoaded({@required this.products});
}

class ProductDataError extends ProductState{}