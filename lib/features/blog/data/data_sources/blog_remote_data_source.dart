import 'dart:io';

import 'package:blog/core/error/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  ///upload blog data in supabase
  Future<BlogModel> uploadBlog(BlogModel blogModel);
///upload and then get the blog image url from supabase storage
  Future<String> getImageUrl({
    required BlogModel blogModel,
    required File path,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImpl({required this.client});

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      ///insert method to add adn upload blog data in supabase
      final blogData =
          await client.from('blogs').insert(blogModel.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> getImageUrl({
    required BlogModel blogModel,
    required File path,
  }) async {
    try {
      ///upload image in supabase storage
      await client.storage.from('blog_image').upload(blogModel.id, path);
      ///get image url from supabase storage
      final url = client.storage.from('blog_image').getPublicUrl(blogModel.id);
      return url;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
