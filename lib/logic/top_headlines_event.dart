part of 'top_headlines_bloc.dart';

@immutable
abstract class TopHeadlinesEvent extends Equatable {}

class FetchTopHeadLines extends TopHeadlinesEvent {
  @override
  List<Object> get props => [];
}
