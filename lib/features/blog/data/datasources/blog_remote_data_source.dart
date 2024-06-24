import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<void> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({
    required String id,
    required File? file,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImp implements BlogRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  BlogRemoteDataSourceImp(this.firebaseFirestore, this.firebaseStorage);

  @override
  Future<void> uploadBlog(BlogModel blogModel) async {
    try {
      await firebaseFirestore
          .collection('blogs')
          .doc(blogModel.id)
          .set(blogModel.toMap());
    } catch (e) {
      throw SupaExceptions(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required String id, required File? file}) async {
    try {
      TaskSnapshot uploadTaskSnapshot =
          await firebaseStorage.ref().child(id).putFile(file!);
      String downloadUrl = await uploadTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw SupaExceptions(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {

      


      final blogs = await firebaseFirestore.collection('blogs').get().then(
          (value) =>
              value.docs.map((e) => BlogModel.fromMap(e.data())).toList());

      return blogs;
    } catch (e) {
      throw SupaExceptions(message: e.toString());
    }
  }
}
