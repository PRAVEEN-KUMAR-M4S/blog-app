import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetBlogs implements UserCase<List<Blog>, Noparams> {
  final BlogRepository blogRepository;

  GetBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(Noparams params) async {
    return await blogRepository.getAllBlogs();
  }
}
