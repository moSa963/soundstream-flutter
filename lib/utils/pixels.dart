import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:image/image.dart" as img;
import 'package:soundstream_flutter/utils/ordered_list.dart';

class Pixels {
  /// Returns the dominat color of an image
  ///
  /// The smaller the [sensitivity] the more specific the color
  ///
  /// [gap] is how much pixel to jump each iteration
  static Future<Color?> findDominantColor(img.Image image,
      {int sensitivity = 30, int gap = 16}) async {
    final colors =
        await Isolate.run(() => _getColorList(image, gap, sensitivity));

    if (colors.isEmpty) return null;

    return mix(colors
        .map((e) => e["pixel"] as img.Pixel)
        .toList()
        .sublist(0, min(6, colors.length)));
  }

  static List<Map<String, dynamic>> _getColorList(
      img.Image image, int gap, int sensitivity) {
    OrderedList<Map<String, dynamic>> colors =
        OrderedList(compare: (v1, v2) => v1["count"] <= v2["count"]);

    for (int i = 0; i < image.width; i += gap) {
      for (int j = 0; j < image.height; j += gap) {
        final pixel = image.getPixel(i, j);

        if (pixel.a < 150) {
          continue;
        }

        bool found = false;

        for (int i = 0; i < colors.length; ++i) {
          if (distance(colors[i]["pixel"], pixel) < sensitivity) {
            final item = colors[i];

            colors.remove(item);

            item["count"]++;

            colors.add(item);

            found = true;
            break;
          }
        }

        if (!found) {
          colors.add({"pixel": pixel, "count": 0});
        }
      }
    }

    return colors.toList();
  }

  ///Returns the distance between two colors
  static num distance(img.Pixel p1, img.Pixel p2) {
    return sqrt(
        pow(p1.r - p2.r, 2) + pow(p1.g - p2.g, 2) + pow(p1.b - p2.b, 2));
  }

  static Color mix(List<img.Pixel> colors) {
    num r = 0;
    num g = 0;
    num b = 0;

    for (int i = 0; i < colors.length; ++i) {
      r += colors[i].r;
      g += colors[i].g;
      b += colors[i].b;
    }

    return Color.fromRGBO(
        r ~/ colors.length, g ~/ colors.length, b ~/ colors.length, 1);
  }
}
