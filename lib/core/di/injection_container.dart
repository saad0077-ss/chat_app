import 'package:chat_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:chat_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:chat_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

/// Service Locator Instance (sl)
final sl = GetIt.instance;

/// Initializes all application dependencies across Data, Domain, and Presentation layers.
Future<void> initInjectionContainer() async {
  // =========================================================================
  // 1. External Dependencies (Firebase)
  // =========================================================================
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // =========================================================================
  // 2. Data Sources
  // =========================================================================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // =========================================================================
  // 3. Repositories
  // =========================================================================
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // =========================================================================
  // 4. Use Cases
  // =========================================================================
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // =========================================================================
  // 5. BLoCs (Factory = create a new instance each time requested)
  // =========================================================================
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}