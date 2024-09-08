import '../../domain/entity/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel(
      {required super.title,
      required super.id,
      required super.posterId,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.updatedAt,
      super.name});

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'poster_id': posterId,
        'content': content,
        'image_url': imageUrl,
        'topics': topics,
        'updated_at': updatedAt.toIso8601String(),
      };

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        title: json['title'],
        id: json['id'],
        posterId: json['poster_id'],
        content: json['content'],
        imageUrl: json['image_url'],
        topics: List<String>.from(json['topics']),
        updatedAt: json['updated_at'] == null
            ? DateTime.now()
            : DateTime.parse(json['updated_at']),
      );

  BlogModel copyWith({
    String? title,
    String? id,
    String? posterId,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? name,
  }) {
    return BlogModel(
      title: title ?? this.title,
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }
}
