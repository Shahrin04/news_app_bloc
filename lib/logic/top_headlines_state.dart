part of 'top_headlines_bloc.dart';

@immutable
abstract class TopHeadlinesState extends Equatable {}

class TopHeadlinesInitial extends TopHeadlinesState {
  @override
  List<Object> get props => [];
}

class TopHeadlinesLoading extends TopHeadlinesState {
  @override
  List<Object> get props => [];
}

class TopHeadlinesNotLoaded extends TopHeadlinesState {
  @override
  List<Object> get props => [];
}

class TopHeadlinesLoadComplete extends TopHeadlinesState {
  final _topHeadLines;

  TopHeadlinesLoadComplete(this._topHeadLines);

  ArticleResponse get getTopHeadLines => _topHeadLines;

  @override
  List<Object> get props => [this._topHeadLines];
}
