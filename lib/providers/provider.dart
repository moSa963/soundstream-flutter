import 'package:flutter/material.dart';

abstract class Provider with ChangeNotifier {
  bool _loading;
  bool get loading => _loading;

  Provider() : _loading = false;

  @protected
  Future<dynamic> withLoading(dynamic Function() i) async {
    if (_loading) return;

    _loading = true;
    notifyListeners();

    late dynamic val;

    try {
      val = await i.call();
    } finally {
      _loading = false;
      notifyListeners();
    }

    return val;
  }
}
