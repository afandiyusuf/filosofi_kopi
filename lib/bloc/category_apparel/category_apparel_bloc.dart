import 'package:filkop_mobile_apps/bloc/category_apparel/category_apparel_event.dart';
import 'package:filkop_mobile_apps/bloc/category_apparel/category_apparel_state.dart';
import 'package:filkop_mobile_apps/model/category_apparel_model.dart';
import 'package:filkop_mobile_apps/repository/category_apparel_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryApparelBloc extends Bloc<CategoryApparelEvent, CategoryApparelState>{
  final CategoryApparelRepository repository;
  CategoryApparelModel _categoryApparelModel;
  CategoryApparelBloc({this.repository}) : super(CategoryApparelEmpty());

  @override
  Stream<CategoryApparelState> mapEventToState(CategoryApparelEvent event) async* {
    if(event is FetchCategoryApparel){
      yield CategoryApparelUpdating();
      CategoryApparelModel categoryProductModel = await repository.getCategoryApparelModel();
      _categoryApparelModel = categoryProductModel;
      if(categoryProductModel == null){
        yield CategoryApparelError();
      }else{
        yield CategoryApparelUpdated(categoryApparelModel:categoryProductModel);
      }
    }

    if(event is SelectCategoryApparel){
      yield CategoryApparelUpdating();
      _categoryApparelModel.select(event.categoryName);
      yield CategoryApparelUpdated(categoryApparelModel: _categoryApparelModel);
    }
  }
}