import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;


  AuthRemoteDataSourceImpl(this.auth, this.db);

  @override
  Future<UserModel> signIn({required String email, required String password}) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDoc = await db.collection(Keys.accountsCollection).doc(userCredential.user?.uid).get();
      if (!userDoc.exists) {
        throw const ServerException('User data not found');
      }

      return UserModel.fromFirestore(userDoc);
    } on FirebaseAuthException catch (e, stackTrace) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw const WrongCredentialsException('Invalid email or password');
      } else {
        throw ServerException(
          e.message ?? 'Authentication failed', 
          stackTrace,
        );
      }
    } catch (e, stackTrace) {
      throw ServerException(
        'An unexpected error occurred during sign in', 
        stackTrace,
      );
    }
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
      );
      await db.collection(Keys.accountsCollection)
        .doc(userCredential.user!.uid)
        .set(userModel.toJson());
      return userModel;
    } on FirebaseAuthException catch (e, stackTrace) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException(
          'The email address is already in use', 
          stackTrace,
        );
      } else {
        throw ServerException(
          e.message ?? 'Registration failed', 
          stackTrace,
        );
      }
    } catch (e, stackTrace) {
      throw ServerException(
        'An unexpected error occurred during sign up', 
        stackTrace,
      );
    }
  }
}
