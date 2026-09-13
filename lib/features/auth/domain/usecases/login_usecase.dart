import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecase/usecase.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  const LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
