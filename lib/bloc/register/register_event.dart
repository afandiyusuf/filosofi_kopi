import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SendDataRegister extends RegisterEvent {
  final String username;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String birthDate;
  final String password;
  final String gender;
  final String province;
  final String city;
  final String pin;

  SendDataRegister(
      {this.username,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.birthDate,
      this.password,
      this.gender,
      this.province,
      this.city,
      this.pin});
}
