import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/use_case/use_case_inteface.dart';
import '../entity/blog_entity.dart';

class UploadBlogUseCase
    implements UseCaseInterface<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async{
   return await blogRepository.getBlog(
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      image: params.image,
      topics: params.topics,
    );

  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.posterId,
  });
}
