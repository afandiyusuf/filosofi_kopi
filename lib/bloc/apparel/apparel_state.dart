import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/apparel_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ApparelState extends Equatable{
  const ApparelState();
  @override
  List<Object> get props => [];
}

class ApparelEmpty extends ApparelState{}
class ApparelDataLoading extends ApparelState{}
class ApparelDataLoaded extends ApparelState{
  final ApparelModel apparels;

  @override
  List<Object> get props => [apparels];
  const ApparelDataLoaded({@required this.apparels});
}

class ApparelDataError extends ApparelState{}