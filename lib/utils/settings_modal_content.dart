import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/setting_widget.dart';

import '../global.dart';

class SettingsModalContent extends StatelessWidget {
  const SettingsModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingWidget(
          text: "Show NSFW content \n(I'm over 18)",
          icon: Icons.remove_red_eye_outlined,
          jsonKey: "over_18",
          getBool: Global.redditor!.over18,
        ),
        SettingWidget(
          text: "Dark mode",
          icon: Icons.nightlight_outlined,
          jsonKey: "nightmode",
          getBool: Global.redditor!.data!["pref_nightmode"],
        ),
        SettingWidget(
          text: "Allow people to follow you",
          icon: Icons.person_add_alt,
          jsonKey: "enable_followers",
          getBool: Global.redditor!.data!["accept_followers"],
        ),
        SettingWidget(
          text: "Autoplay media",
          icon: Icons.video_settings_sharp,
          jsonKey: "video_autoplay",
          getBool: Global.redditor!.data!["pref_video_autoplay"],
        ),
        SettingWidget(
          text: "Opt into beta tests",
          icon: Icons.handyman_outlined,
          jsonKey: "beta",
          getBool: Global.redditor!.data!["in_beta"],
        ),
        SettingWidget(
          text: "Opt into the redesign",
          icon: Icons.design_services_outlined,
          jsonKey: "in_redesign_beta",
          getBool: Global.redditor!.data!["in_redesign_beta"],
        ),
      ],
    );
  }
}
