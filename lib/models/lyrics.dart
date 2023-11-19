class Lyrics {
  List<String> lyrics;
  List<String> timestamps;

  Lyrics({
    this.lyrics = const [],
    this.timestamps = const [],
  });

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return Lyrics(
      lyrics: (json['lyrics'] as String).split("\\n"),
      timestamps: (json['timestamps'] as String).split(","),
    );
  }
}
