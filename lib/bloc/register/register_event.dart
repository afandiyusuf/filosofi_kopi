import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SendDataRegister extends RegisterEvent{
  final String username;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String birthDate;
  final String refferalCode;
  final String password;
  SendDataRegister({this.username, this.email, this.phoneNumber, this.fullName, this.birthDate, this.refferalCode, this.password});
}
