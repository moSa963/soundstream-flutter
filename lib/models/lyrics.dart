import 'dart:convert';

class Lyrics {
  List<String> lyrics;
  List<String> timestamps;

  Lyrics({
    this.lyrics = const [],
    this.timestamps = const [],
  });

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return Lyrics(
      lyrics: LineSplitter.split((json['lyrics'] as String)).toList(),
      timestamps: (json['timestamps'] as String).split(","),
    );
  }
}
