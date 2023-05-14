// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/data/constants/keys.dart';
import 'package:panadol/data/models/video.dart';

//todo: here we'll use the youtube reset api to get the playlist
//todo : hence will provide the playlist videos ids
//todo : which we'll use to play the video

class CourseVideosApi {
 //todo: here we'll have just one method to get the playlist videos
  //todo: and it will take the playlist id as parameter which we will ge
  //todo: from the firebase
  Future<List<Video>> getPlaylistVideos({
    required String playlistId,
  }) async {
    Map<String, dynamic>? params = {
      'key': youtubeApiKey,
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '50',
    };
    Uri uri = Uri.https(
      baseUrl,
      subUrl,
      params,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    http.Response response = await http.get(
      uri,
      headers: headers,
    );
    List<Video> videosList = [];
    if (response.statusCode == 200) {
      List<dynamic> items = jsonDecode(response.body)['items'];
      for (var item in items) {
        {
          videosList.add(Video.fromJson(jsonObj: item));
        }
      }
    }
    return videosList;
  }
}
