part of 'source_details_bloc.dart';

@immutable
abstract class SourceDetailsState extends Equatable {}

class SourceDetailsInitial extends SourceDetailsState {
  @override
  List<Object> get props => [];
}

class SourceDetailsLoading extends SourceDetailsState {
  @override
  List<Object> get props => [];
}

class SourceDetailsNotLoaded extends SourceDetailsState {
  @override
  List<Object> get props => [];
}

class SourceDetailsLoadComplete extends SourceDetailsState {
  final _sourceDetail;

  SourceDetailsLoadComplete(this._sourceDetail);

  ArticleResponse get getSourceDetail => _sourceDetail;

  @override
  List<Object> get props => [this._sourceDetail];
}
