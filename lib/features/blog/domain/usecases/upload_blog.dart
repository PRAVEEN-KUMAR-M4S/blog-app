import 'dart:io';

import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UserCase<void, BlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, void>> call(BlogParams params) async {
    return await blogRepository.uploadblog(
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      image: params.image,
      topics: params.topics,
      color: params.color
    );
  }
}

class BlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  final int color;

  BlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics,required this.color});
}
