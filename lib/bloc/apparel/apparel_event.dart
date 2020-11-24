import 'package:equatable/equatable.dart';

abstract class ApparelEvent extends Equatable{
  const ApparelEvent();
  @override
  List<Object> get props => [];
}

class FetchApparel extends ApparelEvent{
  final String store;
  const FetchApparel({this.store});
}

class SetApparelByCategory extends ApparelEvent{
  final String categoryName;
  const SetApparelByCategory({this.categoryName});
}

class RefreshApparel extends ApparelEvent{}