import 'package:filkop_mobile_apps/bloc/product/product_event.dart';
import 'package:filkop_mobile_apps/bloc/product/product_state.dart';
import 'package:filkop_mobile_apps/model/product_model.dart';
import 'package:filkop_mobile_apps/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository repository;
  Product selectedProduct;
  ProductModel _productModel;
  ProductBloc({@required this.repository}) : assert(repository != null), super(ProductEmpty());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    yield ProductDataLoading();

    if(event is FetchProduct){
      try{
        _productModel = await repository.getProductModelByStore(event.store);
        print("FETCH PRODUCT FROM BLOC $_productModel");
        yield ProductDataLoaded(products: _productModel);
      }catch(_){
        print(_.toString());
        yield ProductDataError();
      }
    }

    if(event is SetProductsByCategory){
      print("SET PRODUCT BY CATEGORY?");
      try{
         _productModel.setByCategory(event.categoryName);
         yield ProductDataLoaded(products: _productModel);
      }catch(_){
        print(_.toString());
        yield ProductDataError();
      }
    }

    if(event is RefreshProduct){
      if(_productModel == null){
        SharedPreferences pref = await SharedPreferences.getInstance();
        String location = pref.getString('location');
        _productModel = await repository.getProductModelByStore(location);
      }
      yield ProductDataLoaded(products: _productModel);
    }
  }
  
}