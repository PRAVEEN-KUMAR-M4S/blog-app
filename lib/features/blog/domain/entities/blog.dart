class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imgUrl;
  final List<String> topics;
  final DateTime updatedAt;
  final int color;


  Blog({
    required this.color,
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imgUrl,
    required this.topics,
    required this.updatedAt,

  });
}
