import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';

class CategoryProductState extends Equatable{
  @override
  List<Object> get props  => [];
}

class CategoryProductEmpty extends CategoryProductState{}

class CategoryProductUpdating extends CategoryProductState{}

class CategoryProductUpdated extends CategoryProductState{
  final CategoryProductModel categoryProductModel;
  CategoryProductUpdated({this.categoryProductModel});
}

class CategoryProductError extends CategoryProductState{}