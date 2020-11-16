import 'package:equatable/equatable.dart';
class CategoryApparelEvent extends Equatable{
  @override
  List<Object> get props  => [];
}

class FetchCategoryApparel extends CategoryApparelEvent{
  FetchCategoryApparel();
}

class SelectCategoryApparel extends CategoryApparelEvent{
  final String categoryName;
  SelectCategoryApparel(this.categoryName);
}