import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  });
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception("user is null after sign in.");
    }

    return UserModel.fromFirebaseUser(credential.user!);
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception("User is null after registration");
    }

    if (name != null && name.isNotEmpty) {
      await credential.user!.updateDisplayName(name);
    }

    return UserModel.fromFirebaseUser(credential.user!);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async{ 
    final currentUser = firebaseAuth.currentUser;
    if(currentUser != null){
      return UserModel.fromFirebaseUser(currentUser);
    }
    return null;
  }
}
