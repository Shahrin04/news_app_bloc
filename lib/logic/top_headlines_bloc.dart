import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data/models/article_response.dart';
import 'package:news_app/data/repo/news_repository.dart';

part 'top_headlines_event.dart';

part 'top_headlines_state.dart';

class TopHeadlinesBloc extends Bloc<TopHeadlinesEvent, TopHeadlinesState> {
  NewsRepository newsRepo;

  TopHeadlinesBloc({this.newsRepo}) : super(TopHeadlinesInitial());

  @override
  Stream<TopHeadlinesState> mapEventToState(
    TopHeadlinesEvent event,
  ) async* {
    if (event is FetchTopHeadLines) {
      yield TopHeadlinesLoading();
      try {
        ArticleResponse articleResponse = await newsRepo.getTopHeadLines();
        yield TopHeadlinesLoadComplete(articleResponse);
      } on Exception catch (e) {
        print('Top Headlines Bloc error: ' + e.toString());
        yield TopHeadlinesNotLoaded();
      }
    }
  }
}
