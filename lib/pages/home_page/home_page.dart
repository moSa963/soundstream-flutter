import 'package:flutter/material.dart';
import 'package:soundstream_flutter/pages/home_page/home_page_bottom_navigator.dart';
import 'package:soundstream_flutter/pages/library_page/library_page.dart';
import 'package:soundstream_flutter/pages/library_page/library_page_appbar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final List<Map<String, dynamic>>  pages = [
    {
      "appbar": null,
      "screen": const Text("index"),
    },
    {
      "appbar": null,
      "screen": const Text("search"),
    },
    {
      "appbar": const LibraryPageAppbar(),
      "screen": const LibraryPage(),
    },
    {
      "appbar": null,
      "screen": const Text("account"),
    },
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.pages[_index]["appbar"],
      body: widget.pages[_index]["screen"],
      bottomNavigationBar: HomePageBottomNavigator(
        index: _index,
        onChange: onIndexChange,
      ),
    );
  }

  void onIndexChange(int i) {
    if (_index == i) return;

    setState(() {
      _index = i;
    });
  }
}
