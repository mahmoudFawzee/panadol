part of 'youtube_player_cubit.dart';

@immutable
abstract class YoutubePlayerState extends Equatable {
  const YoutubePlayerState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class YoutubeCubitInitialState extends YoutubePlayerState {
  const YoutubeCubitInitialState();
  @override
  // TODO: implement props
  List<Object?> get props => super.props;
}

class GotVideoIdState extends YoutubePlayerState {
  final String videoId;
  const GotVideoIdState({
    required this.videoId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        videoId,
      ];
}

class GotVideoIdErrorState extends YoutubePlayerState {
  final String error;
  const GotVideoIdErrorState({
    required this.error,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        error,
      ];
}

class VideoPlayerLoadingState extends YoutubePlayerState {
  const VideoPlayerLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => super.props;
}
