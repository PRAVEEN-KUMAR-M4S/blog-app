import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/core/cubits/cubit/app_user_cubit.dart';

import 'package:flutter_blog_app/features/auth/data/datsources/auth_remote_datasources.dart';
import 'package:flutter_blog_app/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/usecase/get_current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/usecase/user_sign_in.dart';
import 'package:flutter_blog_app/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/repository/blog_repository_imp.dart';
import 'package:flutter_blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_blog_app/firebase_options.dart';
import 'package:get_it/get_it.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initBlog();
  // final supabase = await Supabase.initialize(
  //   url: Keys.url,
  //   anonKey: Keys.apikey,
  // );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  serviceLocator.registerLazySingleton(() => firebaseStorage);
  serviceLocator.registerLazySingleton(() => firebaseAuth);
  serviceLocator.registerLazySingleton(() => firebaseFirestore);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasources>(
    () => AuthRemoteDatasourcesImp(
      firebaseAuth: serviceLocator(),
      firebaseFirestore: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignIn(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator
      .registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImp(
            serviceLocator(),
            serviceLocator(),
          ));

  serviceLocator.registerFactory<BlogRepository>(
      () => BlogRepositoryImp(serviceLocator()));

  serviceLocator.registerFactory(() => UploadBlog(serviceLocator()));

  serviceLocator.registerFactory(() => GetBlogs(serviceLocator()));


  serviceLocator.registerLazySingleton(
      () => BlogBloc(serviceLocator(), serviceLocator()));
}
