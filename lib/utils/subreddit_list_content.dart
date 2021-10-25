import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';

class SubredditListContent extends StatelessWidget {
  const SubredditListContent(
      {Key? key, required this.title, required this.iconUrl})
      : super(key: key);

  final String title;
  final Uri? iconUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Global.screenHeight / 15,
      child: Row(
        children: [
          const Spacer(),
          if (iconUrl == null || iconUrl.toString() == "") ...[
            CircleAvatar(
              radius: Global.screenHeight / 40,
              backgroundImage: const AssetImage("assets/placeholder.png"),
            ),
          ] else ...[
            CircleAvatar(
              radius: Global.screenHeight / 40,
              backgroundImage: NetworkImage(iconUrl.toString()),
            ),
          ],
          const Spacer(flex: 1),
          SizedBox(
            width: Global.screenWidth / 1.5,
            child: Text(
              title,
              style: TextStyle(
                fontSize: Global.screenHeight / 48,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          const Spacer(flex: 6),
        ],
      ),
    );
  }
}
