part of 'hot_news_bloc.dart';

@immutable
abstract class HotNewsState extends Equatable {}

class HotNewsInitial extends HotNewsState {
  @override
  List<Object> get props => [];
}

class HotNewsLoading extends HotNewsState {
  @override
  List<Object> get props => [];
}

class HotNewsNotLoaded extends HotNewsState {
  @override
  List<Object> get props => [];
}

class HotNewsLoadComplete extends HotNewsState {
  final _hotNews;

  HotNewsLoadComplete(this._hotNews);

  ArticleResponse get getHotNews => _hotNews;

  @override
  List<Object> get props => [];
}
