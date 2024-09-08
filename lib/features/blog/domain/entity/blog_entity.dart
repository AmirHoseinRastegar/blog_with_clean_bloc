class BlogEntity {
  final String title;
  final String id;
  final String posterId;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;
  final String? name;

  BlogEntity({
    required this.title,
    required this.id,
    required this.posterId,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
    this.name
  });


}
