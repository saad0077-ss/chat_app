import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecase/usecase.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase implements UseCase<UserEntity,RegisterParams>{
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure,UserEntity>> call(RegisterParams params) async {
    return await authRepository.register(email: params.email, password: params.password,name:params.name);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String? name;

  const RegisterParams({
    required this.email,
    required this.password,
    this.name
  });

  @override
  List<Object?> get props => [email,password,name];
}