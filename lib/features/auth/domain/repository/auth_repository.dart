import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/core/error/failure.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailandPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> signInWithEmailandPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> currentUser();
}
