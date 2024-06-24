import 'dart:io';

import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, void>> uploadblog(
      {required String posterId,
      required String title,
      required String content,
      required File image,
      required List<String> topics,
      required int color});

  Future<Either<Failure,List<Blog>>> getAllBlogs();
}
