import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout(
      {super.key, required this.body, this.appBar, this.bottomNavigationBar});
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
