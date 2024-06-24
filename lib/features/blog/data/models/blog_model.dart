import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imgUrl,
    required super.topics,
    required super.updatedAt,
    required super.color,

  });

  Blog copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imgUrl,
    List<String>? topics,
    DateTime? updatedAt,
     int? color,
     String? posterName
  }) {
    return Blog(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imgUrl: imgUrl ?? this.imgUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'imgUrl': imgUrl,
      'topics': topics,
      'updatedAt': updatedAt.toIso8601String(),
       'color': color,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imgUrl: map['imgUrl'] as String,
      topics: List<String>.from(map['topics'] ),
      updatedAt: map['updatedAt'] == null
          ? DateTime.now()
          : DateTime.parse(map['updatedAt']),
        color: map['color'] as int,
        

    );
  }
}
