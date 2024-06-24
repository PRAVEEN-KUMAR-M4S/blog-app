import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/core/cubits/cubit/app_user_cubit.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';

import 'package:flutter_blog_app/features/auth/domain/usecase/get_current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/usecase/user_sign_in.dart';
import 'package:flutter_blog_app/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required AppUserCubit appUserCubit,
      required CurrentUser currentUser,
      required UserSignUp userSignUp,
      required UserSignIn userSignIn})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(Noparams());
    res.fold((l) => emit(AuthFailure(error: l.error)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(error: l.error)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
        AuthSignInParams(email: event.email, password: event.password));

    res.fold((l) => emit(AuthFailure(error: l.error)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
