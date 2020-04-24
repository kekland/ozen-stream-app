class Track {
  final String title;
  final String author;
  final String albumCoverUrl;

  Track({
    this.title,
    this.author,
    this.albumCoverUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    final title = json['title'].split(' - ');
    
    return Track(
      author: title[0],
      title: title[1],
      albumCoverUrl: json['artwork_url_large'],
    );
  }
}
