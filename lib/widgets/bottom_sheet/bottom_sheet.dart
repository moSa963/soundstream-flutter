import 'package:flutter/material.dart';

class BottomSheetCard extends StatelessWidget {
  const BottomSheetCard(
      {super.key, this.children = const <Widget>[], this.progressing = false});

  final List<Widget> children;
  final bool progressing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .75,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            if (progressing) const LinearProgressIndicator(),
            const SizedBox(
              height: 30,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
