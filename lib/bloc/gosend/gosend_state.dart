import 'package:equatable/equatable.dart';
import 'package:filkop_mobile_apps/model/gosend_model.dart';

class GosendState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GosendInitState extends GosendState{}
class GosendUpdating extends GosendState{}
class GosendUpdated extends GosendState{
  final List<Gosend> datas;
  final Gosend selectedGosend;
  GosendUpdated({this.datas, this.selectedGosend});
}
class GosendError extends GosendState{
  final String message;
  GosendError(this.message);
}