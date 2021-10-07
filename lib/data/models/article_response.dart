import 'package:news_app/data/models/article_model.dart';

class ArticleResponse {
  final List<ArticleModel> articles;
  final String error;

  ArticleResponse({this.articles, this.error});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      error: '',
      articles: (json['articles'] as List)
          .map((i) => ArticleModel.fromJson(i))
          .toList(),
    );
  }

  factory ArticleResponse.withError(String errorValue){
    return ArticleResponse(
      articles: [],
      error: errorValue
    );
  }
}
