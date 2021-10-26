import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/pages/posts_page.dart';

class SubredditListContent extends StatelessWidget {
  const SubredditListContent({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.element,
  }) : super(key: key);

  final String title;
  final Uri? iconUrl;
  final Subreddit element;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/posts',
            arguments: SubredditPostArguments(element));
      },
      child: SizedBox(
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
      ),
    );
  }
}
