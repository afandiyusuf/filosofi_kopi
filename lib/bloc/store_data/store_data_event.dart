import 'package:equatable/equatable.dart';

abstract class StoreDataEvent extends Equatable{
  const StoreDataEvent();
}

class FetchStoreData extends StoreDataEvent{
  const FetchStoreData();

  @override
  List<Object> get props => [];
}