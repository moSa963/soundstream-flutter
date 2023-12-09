import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:soundstream_flutter/services/api_service.dart';
import 'package:soundstream_flutter/utils/pixels.dart';

class AnalyzedImage extends StatefulWidget {
  const AnalyzedImage({super.key, required this.src, this.fit, this.onColor});
  final String src;
  final void Function(Color)? onColor;
  final BoxFit? fit;
  final api = const ApiService();

  @override
  State<AnalyzedImage> createState() => _AnalyzedImageState();
}

class _AnalyzedImageState extends State<AnalyzedImage> {
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant AnalyzedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src == widget.src) return;
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.src,
      fit: widget.fit,
    );
  }

  void _loadData() async {
    final res =
        await NetworkAssetBundle(Uri.parse(widget.src)).load(widget.src);
    if (mounted) {
      setState(() {
        _bytes = res.buffer.asUint8List();
        findColor();
      });
    }
  }

  Future<void> findColor() async {
    if (_bytes == null) return;

    final image = img.decodeImage(_bytes!);

    if (image == null) return;

    Color? color = await Pixels.findDominantColor(image);

    if (color == null) return;

    widget.onColor?.call(color);
  }
}
