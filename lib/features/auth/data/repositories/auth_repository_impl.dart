import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapFirebaseAuthErrorCode(e.code)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final userModel = await remoteDataSource.register(
        email: email,
        password: password,
      );
      return Right(userModel);
    } on FirebaseException catch (e) {
      return Left(AuthFailure(_mapFirebaseAuthErrorCode(e.code)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      if (userModel == null) {
        return Left(AuthFailure('No authenticated user found.'));
      }
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _mapFirebaseAuthErrorCode(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An Account already exist for this email';
      case 'invalid-email':
        return 'This email address is invalid';
      case 'weak-password':
        return 'The password provided is too weak (minimum 6 character)';
      case 'user-disabled':
        return 'This user account has been disabled';
      default:
        return 'Authentication failed: $code';
    }
  }
}
