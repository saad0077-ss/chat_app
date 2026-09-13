import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecase/usecase.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?,NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  @override
  Future<Either<Failure,UserEntity?>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}