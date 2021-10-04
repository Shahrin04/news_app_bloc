import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/Data/models/article_response.dart';
import 'package:news_app/Data/repo/news_repository.dart';

part 'source_details_event.dart';
part 'source_details_state.dart';

class SourceDetailsBloc extends Bloc<SourceDetailsEvent, SourceDetailsState> {
  NewsRepository newsRepo;

  SourceDetailsBloc({this.newsRepo}) : super(SourceDetailsInitial());

  @override
  Stream<SourceDetailsState> mapEventToState(SourceDetailsEvent event) async* {
    if(event is FetchSourceDetails){
      yield SourceDetailsLoading();

      try {
        ArticleResponse articleResponse = await newsRepo.getSourceNews(event._sourceId);
        yield SourceDetailsLoadComplete(articleResponse);
      } on Exception catch (error) {
        print('Source Details Bloc Error: ' + error.toString());
        yield SourceDetailsNotLoaded();
      }
    }
  }
}
