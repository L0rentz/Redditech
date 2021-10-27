import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/future_builder_functions.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/subreddit_posts_list.dart';
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
      body: Builder(builder: (context) {
        return PostLists(
            element: args.element,
            futureFunction: FutureBuilderFunctions.getPostsFromSubreddit,
            limit: 20,
            iconUrl: args.element.data!["icon_img"],
            name: args.element.displayName,
            bannerUrl: bannerUrl);
      }),
      title: args.element.title,
    );
  }
}
