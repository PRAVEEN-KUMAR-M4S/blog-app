import 'dart:io';

import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImp(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, void>> uploadblog(
      {required String posterId,
      required String title,
      required String content,
      required File image,
      required List<String> topics,
      required int color}) async {
    try {
      final blogId = const Uuid().v1();
      final img =
          await blogRemoteDataSource.uploadBlogImage(id: blogId, file: image);
      BlogModel blogModel = BlogModel(
          id: blogId,
          posterId: posterId,
          title: title,
          content: content,
          imgUrl: img,
          topics: topics,
          updatedAt: DateTime.now(),
          color: color);

      await blogRemoteDataSource.uploadBlog(blogModel);
      return right(null);
    } on SupaExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on SupaExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
