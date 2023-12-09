import 'dart:isolate';
import 'dart:math';

import 'package:flutter/services.dart';
import "package:image/image.dart" as img;

class Pixels {
  /// Returns the dominat color of an image
  ///
  /// The smaller the [sensitivity] the more specific the color
  ///
  /// [gap] is how much pixel to jump each iteration
  static Future<Color?> findDominantColor(img.Image image,
      {int sensitivity = 30, int gap = 16}) async {
    img.Pixel? pixel = await Isolate.run<img.Pixel?>(() {
      final map = {};
      int max = 0;
      img.Pixel? color;

      for (int i = 0; i < image.width; i += gap) {
        for (int j = 0; j < image.height; j += gap) {
          final pixel = image.getPixel(i, j);

          if (pixel.a < 150) {
            continue;
          }

          bool found = false;

          for (final value in map.values) {
            if (distance(value["pixel"], pixel) < sensitivity) {
              value["count"]++;
              if (value["count"]! > max) {
                max = value["count"]!;
                color = pixel;
              }
              found = true;
            }
          }

          if (!found) {
            String key = "${pixel.r} ${pixel.g} ${pixel.b}";
            map[key] = {"pixel": pixel, "count": 0};
          }
        }
      }

      return color;
    });

    if (pixel == null) return null;

    return Color.fromRGBO(pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt(), 1);
  }

  ///Returns the distance between two colors
  static num distance(img.Pixel p1, img.Pixel p2) {
    return sqrt(
        pow(p1.r - p2.r, 2) + pow(p1.g - p2.g, 2) + pow(p1.b - p2.b, 2));
  }
}
