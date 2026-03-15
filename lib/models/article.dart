// lib/models/article.dart
import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0) final String title;
  @HiveField(1) final String? description;
  @HiveField(2) final String? urlToImage;
  @HiveField(3) final String? url;
  @HiveField(4) final String? source;
  @HiveField(5) final String? publishedAt;
  @HiveField(6) final String? content;

  Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.source,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json['title'] ?? '',
    description: json['description'],
    urlToImage: json['urlToImage'],
    url: json['url'],
    source: json['source']?['name'],
    publishedAt: json['publishedAt'],
    content: json['content'],
  );
}