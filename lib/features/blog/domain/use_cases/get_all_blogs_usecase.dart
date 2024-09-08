import 'package:blog/core/error/failure.dart';
import 'package:blog/core/use_case/use_case_inteface.dart';
import 'package:blog/features/blog/domain/entity/blog_entity.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetALlBlogsUseCase
    implements UseCaseInterface<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;

  GetALlBlogsUseCase(this.blogRepository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
