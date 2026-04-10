// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  title: json['title'] as String?,
  description: json['description'] as String?,
  url: json['url'] as String?,
  urlToImage: json['urlToImage'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  content: json['content'] as String?,
  source: json['source'] == null
      ? null
      : Source.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'url': instance.url,
  'urlToImage': instance.urlToImage,
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'content': instance.content,
  'source': instance.source,
};

Source _$SourceFromJson(Map<String, dynamic> json) =>
    Source(id: json['id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
