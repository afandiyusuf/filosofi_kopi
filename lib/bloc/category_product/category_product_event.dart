import 'package:equatable/equatable.dart';
class CategoryProductEvent extends Equatable{
  @override
  List<Object> get props  => [];
}

class FetchCategoryProduct extends CategoryProductEvent{
  FetchCategoryProduct();
}

class SelectCategoryProduct extends CategoryProductEvent{
  final String categoryName;
  SelectCategoryProduct(this.categoryName);
}