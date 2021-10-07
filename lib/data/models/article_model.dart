import 'package:news_app/data/models/source_model.dart';

class ArticleModel {
  final SourceModel source;
  final author;
  final title;
  final description;
  final url;
  final image;
  final date;
  final content;

  ArticleModel(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.image,
      this.date,
      this.content});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        source: SourceModel.fromJson(json['source']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        image: json['urlToImage'],
        date: json['publishedAt'],
        content: json['content']);
  }
}
