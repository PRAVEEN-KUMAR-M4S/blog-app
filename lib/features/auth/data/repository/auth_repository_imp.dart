import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/auth/data/datsources/auth_remote_datasources.dart';

import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasources authRemoteDatasources;
 

  AuthRepositoryImp(this.authRemoteDatasources,);
  @override
  Future<Either<Failure, User>> signInWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      // if (await (connetctionChecker.isConnected)) {
      //   return left(Failure('No internet Connection'));
      // }
      final user = await authRemoteDatasources.signInWithEmailandPassword(
          email: email, password: password);
      return right(user);
    } on SupaExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // if (await (connetctionChecker.isConnected)) {
      //   return left(Failure('No internet Connection'));
      // }
      final user = await authRemoteDatasources.signUpWithEmailandPassword(
          name: name, email: email, password: password);
      return right(user);
    } on SupaExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      // if (!await (connetctionChecker.isConnected)) {
      //   print('no connection');
      // }

      final user = await authRemoteDatasources.getCurrentSession();
      if (user == null) {
        return left(Failure('User not loggged In !!!'));
      }
      return right(user);
    } on SupaExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
