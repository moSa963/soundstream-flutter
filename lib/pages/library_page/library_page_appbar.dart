import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/create_album_page.dart';
import 'package:soundstream_flutter/pages/create_playlist_page.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:soundstream_flutter/widgets/user_avatar.dart';

class LibraryPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      title: const Text("Your Library"),
      leading: UserAvatar(user: context.watch<AuthProvider>().auth),
      actions: [
        IconButton(
            onPressed: () => _onCreate(context), icon: const Icon(Icons.add))
      ],
    );
  }

  void openPage(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }

  void _onCreate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetCard(
            children: [
              TextButton(
                  onPressed: () =>
                      openPage(context, const CreatePlaylistPage()),
                  child: const Text("Create Playlist")),
              TextButton(
                  onPressed: () => openPage(context, const CreateAlbumPage()),
                  child: const Text("Create Album")),
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
