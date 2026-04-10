import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart'; // File này sẽ được tự động sinh ra

@JsonSerializable()
class Article {
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? urlToImage;
  @JsonKey(name: 'publishedAt')
  final DateTime? publishedAt;
  final String? content;
  final Source? source;

  Article({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
  });

  // Factory method để tạo object từ JSON
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  // Method để chuyển object thành JSON
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Source {
  final String? id;
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}