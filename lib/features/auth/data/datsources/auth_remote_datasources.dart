import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDatasources {
  Future<UserModel> signUpWithEmailandPassword(
      {required String name, required String email, required String password});

  Future<UserModel> signInWithEmailandPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentSession();

  Stream<User?> get currentUserSession;
}

class AuthRemoteDatasourcesImp implements AuthRemoteDatasources {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDatasourcesImp(
      {required this.firebaseAuth, required this.firebaseFirestore});

  Stream<User?> get currentUserSession => firebaseAuth.authStateChanges();

  @override
  Future<UserModel> signInWithEmailandPassword(
      {required String email, required String password}) async {
    UserModel userModel = UserModel.empty;
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw SupaExceptions(message: 'User is null !');
      }
      userModel.email = response.user!.email!;
      return userModel;
    } catch (e) {
      throw SupaExceptions(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailandPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        password: password,
        email: email,
      );

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.email)
          .set({
        'id': firebaseAuth.currentUser!.email,
        'name': name,
        'email': email
      });

      if (response.user == null) {
        throw SupaExceptions(message: 'User is null !');
      }
      return UserModel.fromMap(response.user as Map<String, dynamic>);
    } catch (e) {
      throw SupaExceptions(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentSession() async {
    try {
      if (firebaseAuth.currentUser != null) {
        final userData = await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.email)
            .get();
        return UserModel.fromMap(userData.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw SupaExceptions(message: e.toString());
    }
  }
}
