const List<Song> songs = [
  Song('theme.mp3', 'Theme', artist: 'NGL'),
  Song('gomi_groove-alt.mp3', 'Groove', artist: 'NGL'),
];

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
