import 'package:filkop_mobile_apps/bloc/register/register_event.dart';
import 'package:filkop_mobile_apps/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  
  RegisterBloc(RegisterState initialState) : super(initialState);

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
  
}