part of 'hot_news_bloc.dart';

@immutable
abstract class HotNewsEvent extends Equatable {}

class FetchHotNews extends HotNewsEvent {
  @override
  List<Object> get props => [];
}

class FetchSearchNews extends HotNewsEvent {
  final search;

  FetchSearchNews({@required this.search});

  @override
  List<Object> get props => [this.search];
}
