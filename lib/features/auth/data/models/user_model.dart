import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    super.displayName
  });

  factory UserModel.fromFirebaseUser(firebase.User user) {
    return UserModel(
      uid:user.uid,
      email:user.email ?? "",
      displayName: user.displayName
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'email':email,
      'displayName':displayName
    };
  }

  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      uid: map['ui'] ?? "",
      email:map['email'] ?? "",
      displayName: map['displayName']
    );
  }
}