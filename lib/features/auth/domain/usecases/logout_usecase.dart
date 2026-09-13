import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecase/usecase.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCase<void,NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  @override
  Future<Either<Failure,void>> call(NoParams) async{
    return await authRepository.logout();
  }
}