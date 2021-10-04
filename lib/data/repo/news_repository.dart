import 'package:dio/dio.dart';
import 'package:news_app/Config/variables.dart';
import 'package:news_app/Data/models/article_response.dart';
import 'package:news_app/Data/models/source_response.dart';

class NewsRepository {
  static String mainUrl = 'https://newsapi.org/v2/';
  final String apiKey = NEWSAPI2;

  final Dio _dio = Dio();

  var getSourceUrl = '$mainUrl/sources';
  var getTopHeadLinesUrl = '$mainUrl/top-headlines';
  var getEverythingUrl = '$mainUrl/everything';

  Future<SourceResponse> getSources() async {
    var params = {
      'apiKey': apiKey,
      'language': 'en',
      'country': 'us',
    };

    try {
      Response response = await _dio.get(getSourceUrl, queryParameters: params);
      return SourceResponse.fromJason(response.data);
    } on Exception catch (error) {
      print("Exception Occurred: $error");
    }
  }

  Future<ArticleResponse> getTopHeadLines() async {
    var params = {
      'apiKey': apiKey,
      'country': 'us',
    };

    try {
      Response response =
          await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      print("Exception Occurred: $error");
    }
  }

  Future<ArticleResponse> search(String value) async {
    var params = {
      'apiKey': apiKey,
      'q': value,
      'sortBy': 'popularity',
      'language': 'en'
    };

    try {
      Response response =
          await _dio.get(getEverythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } on Exception catch (error) {
      print("Exception Occurred: $error");
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {'apiKey': apiKey, 'q': 'games', 'language': 'en'};

    try {
      Response response =
          await _dio.get(getEverythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } on Exception catch (error) {
      print("Exception Occurred: $error");
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {'apiKey': apiKey, 'sources': sourceId};

    try {
      Response response =
          await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } on Exception catch (error) {
      print("Exception Occurred: $error");
    }
  }
}
