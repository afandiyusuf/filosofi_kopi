import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/category_apparel_model.dart';

class CategoryApparelState extends Equatable{
  @override
  List<Object> get props  => [];
}

class CategoryApparelEmpty extends CategoryApparelState{}

class CategoryApparelUpdating extends CategoryApparelState{}

class CategoryApparelUpdated extends CategoryApparelState{
  final CategoryApparelModel categoryApparelModel;
  CategoryApparelUpdated({this.categoryApparelModel});
}

class CategoryApparelError extends CategoryApparelState{}