import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';

import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UserCase<User, AuthSignInParams> {
  final AuthRepository authRepository;

  UserSignIn( this.authRepository);
  @override
  Future<Either<Failure, User>> call(AuthSignInParams params) async{
    return await authRepository.signInWithEmailandPassword(email: params.email, password: params.password);
  }
}

class AuthSignInParams {
  final String email;
  final String password;

  AuthSignInParams({required this.email, required this.password});
}
