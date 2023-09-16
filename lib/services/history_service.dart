import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class HistoryService {
  const HistoryService();
  final api = const ApiService();

  Future<List<Track>> list({ int? count }) async {
    final js = await api.get("history/tracks${count == null ? "" : "?count=$count"}");
    return (js["data"] as List<dynamic>).map((v) => Track.fromJson(v["track"])).toList();
  }

  Future<void> destroy(Track track) async {
    await api.delete("history/tracks/${track.id}");
  }
}
