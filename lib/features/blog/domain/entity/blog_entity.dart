class BlogEntity {
  final String title;
  final String id;
  final String posterId;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  BlogEntity({
    required this.title,
    required this.id,
    required this.posterId,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });

  BlogEntity.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        posterId = json['poster_id'],
        content = json['content'],
        imageUrl = json['image_url'],
        topics = List<String>.from(json['topics']),
        updatedAt = json['updated_at'] == null
            ? DateTime.now()
            : DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'poster_id': posterId,
        'content': content,
        'image_url': imageUrl,
        'topics': topics,
        'updated_at': updatedAt.toIso8601String(),
      };
}
