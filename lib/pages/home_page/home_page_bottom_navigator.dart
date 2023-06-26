import 'package:flutter/material.dart';

class HomePageBottomNavigator extends StatelessWidget {
  final int index;
  final void Function(int index) onChange;

  const HomePageBottomNavigator({super.key, required this.index, required this.onChange});


  @override
  Widget build(BuildContext context) {
    
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onChange,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: "Library",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: "Account",
        ),
      ],
    );
  }
}
