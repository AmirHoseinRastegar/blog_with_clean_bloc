import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog/core/use_case/use_case_inteface.dart';
import 'package:blog/features/blog/domain/use_cases/get_all_blogs_usecase.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/blog_entity.dart';
import '../../domain/use_cases/upload_blog_usecase.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;
  final GetALlBlogsUseCase getALlBlogsUseCase;

  BlogBloc(this.uploadBlogUseCase, this.getALlBlogsUseCase)
      : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUploadEvent>(_onUpload);
    on<BlogGetALlBlogsEvent>(_onGetAllBlogs);
  }

  void _onUpload(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await uploadBlogUseCase.call(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
        posterId: event.posterId,
      ),
    );
    res.fold((l) => emit(BlogUploadError(l.message)),
        (r) => emit(BlogUploadSuccess()));
  }

  void _onGetAllBlogs(
      BlogGetALlBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await getALlBlogsUseCase.call(NoParams());
    res.fold(
      (l) => emit(
        BlogUploadError(l.message),
      ),
      (r) => emit(
        BlogGetALlBlogsSuccess(r),
      ),
    );
  }
}
