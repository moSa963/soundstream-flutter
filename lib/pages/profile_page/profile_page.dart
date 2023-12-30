import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/pages/page_layout.dart';
import 'package:soundstream_flutter/pages/user_page/user_page_header.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/widgets/button/logout_button.dart';
import 'package:soundstream_flutter/widgets/button/update_profile_image_button.dart';
import 'package:soundstream_flutter/widgets/text_title.dart';
import 'package:soundstream_flutter/widgets/theme_switch.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        body: Column(
      children: [
        UserPageHeader(user: context.watch<AuthProvider>().auth ?? User()),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: const [
              TextTitle("Profile"),
              UpdateProfileImageButton(),
              SizedBox(
                height: 20,
              ),
              TextTitle("Theme"),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Dark theme: "),
                  ThemeSwitch(),
                ],
              ),
              LogoutButton()
            ],
          ),
        ),
      ],
    ));
  }
}
