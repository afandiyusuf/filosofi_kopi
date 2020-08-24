import 'package:filkop_mobile_apps/bloc/register/register_event.dart';
import 'package:filkop_mobile_apps/bloc/register/register_state.dart';
import 'package:filkop_mobile_apps/model/base_response.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiService apiService;
  RegisterBloc({this.apiService}) : super(InitRegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    print('registering');
    yield Registering();

    if (event is SendDataRegister) {
      print('data send');
      String status = await apiService.register(
          event.username,
          event.email,
          event.password,
          event.birthDate,
          event.gender,
          event.province,
          event.city,
          event.phoneNumber,
          event.pin);
      if(status == 'success'){
        print('success try to login');
       BaseResponse baseResponse = await apiService.login(event.email, event.password);
       if(baseResponse.success == true){
         print('login success');
        yield RegisterSuccess();
       }else{
         print('login error');
         yield RegisterError(message: 'User tidak bisa digunakan untuk login');
       }
      }else{
        print('register error');
        yield RegisterError(message: status);
      }
    }
  }
}
