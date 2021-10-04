import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/Data/models/source_response.dart';
import 'package:news_app/Data/repo/news_repository.dart';

part 'top_channels_event.dart';

part 'top_channels_state.dart';

class TopChannelsBloc extends Bloc<TopChannelsEvent, TopChannelsState> {
  NewsRepository newsRepo;

  TopChannelsBloc({this.newsRepo}) : super(TopChannelsInitial());

  @override
  Stream<TopChannelsState> mapEventToState(TopChannelsEvent event) async* {
    if (event is FetchTopChannels) {
      yield TopChannelsLoading();

      try {
        SourceResponse sourceResponse = await newsRepo.getSources();
        yield TopChannelsLoadComplete(sourceResponse);
      } on Exception catch (error) {
        print('Top Channels Bloc Error: ' + error.toString());
        yield TopChannelsNotLoaded();
      }
    }
  }
}
