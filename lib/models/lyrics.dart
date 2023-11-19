import 'dart:convert';

class Lyrics {
  List<String> lyrics;
  List<double> timestamps;

  Lyrics({
    this.lyrics = const [],
    this.timestamps = const [],
  });

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    final stamps = json['timestamps'] as String;

    return Lyrics(
      lyrics: LineSplitter.split((json['lyrics'] as String)).toList(),
      timestamps: stamps.isNotEmpty
          ? stamps.split(",").map((e) => double.parse(e)).toList()
          : [],
    );
  }
}