import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitRegisterState extends RegisterState {}

class Registering extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;
  RegisterError({this.message});
}
