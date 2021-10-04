part of 'source_details_bloc.dart';

@immutable
abstract class SourceDetailsEvent extends Equatable {}

class FetchSourceDetails extends SourceDetailsEvent{
  final _sourceId;

  FetchSourceDetails(this._sourceId);

  @override
  List<Object> get props => [this._sourceId];
}
