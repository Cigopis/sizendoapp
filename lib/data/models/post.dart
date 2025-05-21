class PostModel {
  final String username;
  final String content;
  final String? image;

  PostModel({
    required this.username,
    required this.content,
    this.image,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      username: json['username'],
      content: json['content'],
      image: json['image_path'] != null
          ? 'https://siberzendo.com/${json['image_path']}'
          : null,
    );
  }
}
