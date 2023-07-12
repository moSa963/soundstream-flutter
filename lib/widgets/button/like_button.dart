import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, required this.liked, this.onChange});
  final bool liked;
  final void Function(bool newValue)? onChange;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onChange?.call(!liked),
        icon: Icon(liked ? Icons.favorite : Icons.favorite_outline));
  }
}
