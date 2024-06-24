import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';

import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UserCase<User, Noparams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(Noparams params) async{
    return await authRepository.currentUser();
  }
}
