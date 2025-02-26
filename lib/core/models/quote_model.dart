class QuoteModel {
  final String id;
  final String content;
  final String author;
  final List<String> tags;
  final String authorSlug;
  final int length;
  final String dateAdded;
  final String dateModified;

  QuoteModel({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['_id'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      tags: List<String>.from(json['tags']),
      authorSlug: json['authorSlug'] as String,
      length: json['length'] as int,
      dateAdded: json['dateAdded'] as String,
      dateModified: json['dateModified'] as String,
    );
  }
}