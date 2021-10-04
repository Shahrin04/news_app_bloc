part of 'top_channels_bloc.dart';

@immutable
abstract class TopChannelsEvent extends Equatable {}

class FetchTopChannels extends TopChannelsEvent {
  @override
  List<Object> get props => [];
}
