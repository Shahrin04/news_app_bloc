part of 'top_channels_bloc.dart';

@immutable
abstract class TopChannelsState extends Equatable {}

class TopChannelsInitial extends TopChannelsState {
  @override
  List<Object> get props => [];
}

class TopChannelsLoading extends TopChannelsState {
  @override
  List<Object> get props => [];
}

class TopChannelsNotLoaded extends TopChannelsState {
  @override
  List<Object> get props => [];
}

class TopChannelsLoadComplete extends TopChannelsState {
  final _topChannels;

  TopChannelsLoadComplete(this._topChannels);

  SourceResponse get getTopChannels => _topChannels;

  @override
  List<Object> get props => [this._topChannels];
}
