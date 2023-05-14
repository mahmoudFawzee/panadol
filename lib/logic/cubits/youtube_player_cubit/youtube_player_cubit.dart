// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'youtube_player_state.dart';

class YoutubePlayerCubit extends Cubit<YoutubePlayerState> {
  YoutubePlayerCubit()
      : super(
         const YoutubeCubitInitialState(
          ),
        );

  void playVideoEvent({
    required String videoId,
  }) {
    emit(const VideoPlayerLoadingState());
    try {
      if (videoId.isNotEmpty) {
        emit(GotVideoIdState(videoId: videoId));
      } else {
        emit(const GotVideoIdErrorState(
          error: 'the requested video does not available',
        ));
      }
    } catch (e) {
      emit(GotVideoIdErrorState(error: e.toString()));
    }
  }
}
