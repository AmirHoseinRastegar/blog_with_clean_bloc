import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/upload_blog_usecase.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;

  BlogBloc(this.uploadBlogUseCase) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUploadEvent>(_onUpload);
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
}
