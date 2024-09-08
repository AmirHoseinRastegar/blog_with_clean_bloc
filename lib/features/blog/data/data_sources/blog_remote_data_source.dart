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

  ///to call and show blogs data in blog screen of the app
  Future<List<BlogModel>> getBlogs();
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

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      ///since poster id of blogs data base in supabase is a foreign key
      ///and is connected to profiles data base we can use it
      ///to access the columns of the profiles data base which we want
      ///the name column of it so we do as below , by using * we mean all data
      ///of the blogs database is needed and we want it and then we say
      ///from profiles database we need (name) column of it
      final blogs = await client.from('blogs').select('*, profiles(name)');

      //here we convert our list as a map for looping it into from json methode
      //that we have in blog model so we can access all data coming from data base in
      //dart objects and then we convert it into list by toList methode
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              name: blog['profiles']['name'],
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
