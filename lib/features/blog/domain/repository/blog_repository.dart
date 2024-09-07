import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/domain/entity/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> getBlog({
    required String posterId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  });
}
