import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetBlogs getBlogs;
  BlogBloc(this.uploadBlog, this.getBlogs) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(_onBlogUpload);
    on<BlogGetAllBlogs>(_fetchAllBlogs);
  }

  void _fetchAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    final res = await getBlogs(Noparams());

    res.fold((l) => emit(BlogFailure(error: l.error)),
        (r) => emit(BlogFetchSuccess(blogs: r)));
  }

  void _onBlogUpload(UploadBlogEvent event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(
      BlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics,
          color: event.color),
    );
    res.fold((l) => emit(BlogFailure(error: l.error)),
        (r) => emit(BlogUploadSuccess()));
  }
}
