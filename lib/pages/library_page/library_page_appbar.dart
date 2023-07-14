import 'package:flutter/material.dart';
import 'package:soundstream_flutter/pages/create_playlist_page.dart';
import 'package:soundstream_flutter/widgets/user_avatar.dart';



class LibraryPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      title: const Text("Your Library"),
      leading: const UserAvatar(),
      actions: [
        IconButton(
          onPressed: () => openPage(context, const CreatePlaylistPage()), 
          icon: const Icon(Icons.add)
        )
      ],
    );
  }


  void openPage(BuildContext context, Widget page) {
      Navigator.of(context).push(MaterialPageRoute( builder: (context) {
        return page;
      },));
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}