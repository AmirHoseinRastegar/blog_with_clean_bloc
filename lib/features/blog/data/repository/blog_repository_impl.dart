import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/core/error/server_exception.dart';
import 'package:blog/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';

import 'package:blog/features/blog/domain/entity/blog_entity.dart';

import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repository/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, BlogEntity>> getBlog({
    required String posterId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        title: title,
        id: const Uuid().v1(),
        posterId: posterId,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.getImageUrl(
        blogModel: blogModel,
        path: image,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final res = await blogRemoteDataSource.uploadBlog(blogModel);

      return Right(res);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getBlogs();
      return Right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
