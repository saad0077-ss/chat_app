import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequestEvent extends AuthEvent {}

class AuthLoginRequestEvent  extends AuthEvent {
  final String email;
  final String password;
  
  const AuthLoginRequestEvent({
    required this.email,
    required this.password
  });

  @override
  List<Object?> get props => [email,password];
}


class AuthRegisterRequestedEvent extends AuthEvent {
  final String email;
  final String password;
  final String? name;

   const AuthRegisterRequestedEvent({
    required this.email,
    required this.password,
    this.name,
  });

  @override
  List<Object?> get props => [email,password,name];
}

class AuthLogoutRequestEvent extends AuthEvent {}