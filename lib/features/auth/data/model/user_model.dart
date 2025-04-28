import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_plate/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
    );
  }
}
