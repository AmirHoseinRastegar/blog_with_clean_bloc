part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}
final class BlogLoading extends BlogState {}
final class BlogUploadSuccess extends BlogState {}
final class BlogUploadError extends BlogState {
  final String message;

  BlogUploadError(this.message);
}
// final class Blog extends BlogState {}
