import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/list_item/list_item.dart';

class UploadingItem extends StatelessWidget {
  const UploadingItem({super.key, this.title, this.subtitle});
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: const AspectRatio(
        aspectRatio: 1,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.cloud_upload_outlined)),
        ),
      ),
      title: title ?? "",
      subtitle: subtitle ?? "",
      actions: const [CircularProgressIndicator()],
    );
  }
}
