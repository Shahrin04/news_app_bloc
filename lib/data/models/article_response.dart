import 'package:news_app/Data/models/article_model.dart';

class ArticleResponse {
  final List<ArticleModel> articles;

  ArticleResponse({this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      articles: (json['articles'] as List)
          .map((i) => ArticleModel.fromJson(i))
          .toList(),
    );
  }
}
