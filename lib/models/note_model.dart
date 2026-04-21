import 'dart:convert';

class Note {
  final String id;
  final String content;
  final bool isLiked;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.content,
    required this.isLiked,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'isLiked': isLiked,
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        content: json['content'],
        isLiked: json['isLiked'],
        updatedAt: DateTime.parse(json['updatedAt']),
      );
}