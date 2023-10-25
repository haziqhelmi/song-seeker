class Song {
  int rank = -1;
  String title = '';
  String artist = '';
  String album = '';
  int year = -1;

  Song.fromJson(Map<String, dynamic> json) {
    rank = json.containsKey('rank') ? json['rank'] : -1;
    title = json.containsKey('title') ? json['title'] : '';
    artist = json.containsKey('artist') ? json['artist'] : '';
    album = json.containsKey('album') ? json['album'] : '';
    year = json.containsKey('year') ? int.parse(json['year']) : -1;
  }

  @override
  String toString() {
    return 'Song{rank: $rank, title: $title, artist: $artist, album: $album, year: $year}';
  }
}
