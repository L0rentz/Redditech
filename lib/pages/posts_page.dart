import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/posts_widgets.dart';

class SubredditPostArguments {
  final Subreddit element;

  SubredditPostArguments(this.element);
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SubredditPostArguments;

    final String rawBannerUrl = args.element.data!["banner_background_image"];
    final String bannerUrl = rawBannerUrl.split("?")[0];

    return LoggedScaffold(
      body: Stack(
        children: [
          SizedBox(
            width: Global.screenWidth,
            height: Global.screenHeight * 0.08,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.network(bannerUrl),
            ),
          ),
          NamedAvatar(
              iconUrl: args.element.data!["icon_img"],
              name: "r/" + args.element.displayName),
          // Transform.translate(
          //   offset: Offset(0, Global.minScreenSize * 0.22),
          //   child: SizedBox(
          //     width: Global.screenWidth,
          //     height: Global.screenHeight * 0.08,
          //     child: Container(
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
        ],
      ),
      title: args.element.title,
    );
  }
}
