import 'dart:convert';

class NewsModel {
  String? title;
  String? date;
  String? content;
  String? imageUrl;
  NewsModel({
    this.title,
    this.date,
    this.content,
    this.imageUrl,
  });

  NewsModel copyWith({
    String? title,
    String? date,
    String? content,
    String? imageUrl,
  }) {
    return NewsModel(
      title: title ?? this.title,
      date: date ?? this.date,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'content': content,
      'imageUrl': imageUrl,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'],
      date: map['date'],
      content: map['content'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(title: $title, date: $date, content: $content, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.title == title &&
        other.date == date &&
        other.content == content &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        date.hashCode ^
        content.hashCode ^
        imageUrl.hashCode;
  }
}
