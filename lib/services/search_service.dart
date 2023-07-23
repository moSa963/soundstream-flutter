import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class SearchService {
  const SearchService();

  final _api = const ApiService();

  Future<Map<String, List<dynamic>>> search(String key) async {
    final js = (await _api.get("search/$key"))["data"];
    Map<String, List<dynamic>> res = {};

    res["tracks"] =
        (js["tracks"] as List<dynamic>).map((e) => Track.fromJson(e)).toList();
    res["albums"] = (js["albums"] as List<dynamic>)
        .map((e) => Playlist.fromJson(e))
        .toList();
    res["playlists"] = (js["playlists"] as List<dynamic>)
        .map((e) => Playlist.fromJson(e))
        .toList();
    res["users"] =
        (js["users"] as List<dynamic>).map((e) => User.fromJson(e)).toList();

    return res;
  }
}
