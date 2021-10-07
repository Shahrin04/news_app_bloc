import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data/models/article_response.dart';
import 'package:news_app/data/repo/news_repository.dart';

part 'hot_news_event.dart';

part 'hot_news_state.dart';

class HotNewsBloc extends Bloc<HotNewsEvent, HotNewsState> {
  NewsRepository newsRepo;

  HotNewsBloc({this.newsRepo}) : super(HotNewsInitial());

  @override
  Stream<HotNewsState> mapEventToState(HotNewsEvent event) async* {
    if (event is FetchHotNews) {
      yield HotNewsLoading();

      try {
        ArticleResponse articleResponse = await newsRepo.getHotNews();
        yield HotNewsLoadComplete(articleResponse);
      } on Exception catch (e) {
        print('Hot News Bloc error: ' + e.toString());
        yield HotNewsNotLoaded();
      }
    }else if(event is FetchSearchNews){
      yield HotNewsLoading();

      try {
        ArticleResponse articleResponse = await newsRepo.search(event.search);
        yield HotNewsLoadComplete(articleResponse);
      } on Exception catch (e) {
        print('Hot News Search Bloc error: ' + e.toString());
        yield HotNewsNotLoaded();
      }
    }
  }
}
