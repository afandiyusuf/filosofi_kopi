import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable{
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent{
  final String store;
  const FetchProduct({this.store});
}

class SetProductsByCategory extends ProductEvent{
  final String categoryName;
  const SetProductsByCategory({this.categoryName});
}

class RefreshProduct extends ProductEvent{}