import 'package:filkop_mobile_apps/bloc/category_product/category_product_event.dart';
import 'package:filkop_mobile_apps/bloc/category_product/category_product_state.dart';
import 'package:filkop_mobile_apps/model/category_product_model.dart';
import 'package:filkop_mobile_apps/repository/category_product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductBloc extends Bloc<CategoryProductEvent, CategoryProductState>{
  final CategoryProductRepository repository;
  CategoryProductModel _categoryProductModel;
  CategoryProductBloc({this.repository}) : super(CategoryProductEmpty());

  @override
  Stream<CategoryProductState> mapEventToState(CategoryProductEvent event) async* {
    if(event is FetchCategoryProduct){
      yield CategoryProductUpdating();
      CategoryProductModel categoryProductModel = await repository.getCategoryProductModel();
      _categoryProductModel = categoryProductModel;
      if(categoryProductModel == null){
        yield CategoryProductError();
      }else{
        yield CategoryProductUpdated(categoryProductModel:categoryProductModel);
      }
    }

    if(event is SelectCategoryProduct){
      yield CategoryProductUpdating();
      _categoryProductModel.select(event.categoryName);
      yield CategoryProductUpdated(categoryProductModel: _categoryProductModel);
    }
  }
}