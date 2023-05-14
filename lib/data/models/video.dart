class Video {
  final String id;
  final String title;
  //final String thumbnailUrl;
  //final String channelTitle;
  final int index;
  const Video({
    required this.id,
    required this.title,
    //required this.thumbnailUrl,
    //required this.channelTitle,
    required this.index,
  });
  factory Video.fromJson({required Map<String, dynamic> jsonObj}) {
    // print(jsonObj['snippet']['resourceId']['videoId']);
    // print(jsonObj['snippet']['title']);
    // print(jsonObj['snippet']['position']);
    return Video(
      id: jsonObj['snippet']['resourceId']['videoId'],
      title: jsonObj['snippet']['title'],
      //thumbnailUrl: jsonObj['snippet']['thumbnails']['high']['url'],
      //channelTitle: jsonObj['snippet']['channelTitle'],
      index: jsonObj['snippet']['position'],
    );
  }
}
