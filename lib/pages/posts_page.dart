import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/future_api_functions.dart';
import 'package:flutter_application_1/utils/join_quit_button.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/modal.dart';
import 'package:flutter_application_1/utils/posts_widgets.dart';
import 'package:flutter_application_1/utils/subreddit_list.dart';

import '../global.dart';

class SubredditPostArguments {
  final Subreddit element;
  final Function popRefreshCallback;

  SubredditPostArguments(this.element, this.popRefreshCallback);
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  bool isChecked = false;
  String btnText = "Newest";

  Stack principalStack(
      String bannerUrl, String iconUrl, String name, Subreddit element) {
    return Stack(
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
          iconUrl: iconUrl,
          name: "r/" + name,
          element: element,
        ),
      ],
    );
  }

  Container modalButton(String text) {
    return Container(
      margin: EdgeInsets.all(Global.screenWidth / 80),
      width: Global.screenWidth,
      height: Global.screenHeight / 23,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            btnText = text;
          });
        },
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Column modalContent(Subreddit element) {
    return Column(
      children: [
        modalButton("Newest"),
        modalButton("Hottest"),
        modalButton("Top posts")
      ],
    );
  }

  void refreshCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SubredditPostArguments;

    final String rawBannerUrl = args.element.data!["banner_background_image"];
    String bannerUrl = rawBannerUrl.split("?")[0];
    final Uri? uriIconUrl = args.element.iconImage.toString() == "" ||
            args.element.iconImage == null
        ? args.element.data!["community_icon"] == "" ||
                args.element.data!["community_icon"] == null
            ? Uri.parse("https://i.redd.it/u87eaol1sqi21.png")
            : Uri.parse((args.element.data!["community_icon"]).substring(
                0, (args.element.data!["community_icon"]).indexOf('?')))
        : args.element.iconImage;
    String iconUrl = uriIconUrl.toString();
    final String description = args.element.data!["public_description"];

    inspect(args.element);
    if (rawBannerUrl == "") {
      bannerUrl = "https://i.redd.it/b7usm1cg9ub71.jpg";
    }
    if (iconUrl == "") {
      iconUrl = "https://i.redd.it/u87eaol1sqi21.png";
    }

    Future<bool> _willPopCallback() async {
      await args.popRefreshCallback();
      return true; // return true if the route to be popped
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: LoggedScaffold(
        body: Builder(builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              principalStack(
                  bannerUrl, iconUrl, args.element.displayName, args.element),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Global.screenWidth * 0.04,
                  0.0,
                  Global.screenWidth * 0.04,
                  0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                          0.0,
                          Global.screenHeight * 0.03,
                          0.0,
                          0.0,
                        ),
                        child: Text(
                            args.element.data!["subscribers"].toString() +
                                " subscribers.")),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0.0,
                        Global.screenHeight * 0.01,
                        0.0,
                        0.0,
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          fontSize: Global.minScreenSize * 0.03,
                        ),
                      ),
                    ),
                    const Divider(),
                    const Text("data"),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(Global.screenWidth * 0.02),
                child: GestureDetector(
                  onTap: () {
                    showAccountsModal(context, modalContent(args.element));
                  },
                  child: Row(
                    children: [
                      Text(btnText),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: Global.screenWidth / 20,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SubredditList(
                  filter: btnText,
                  element: args.element,
                  refreshCallback: refreshCallback,
                  futureFunction: FutureApiFunctions.getPostsFromSubreddit,
                  limit: 20,
                  key: UniqueKey(),
                ),
              ),
            ],
          );
        }),
        title: args.element.title,
      ),
    );
  }
}
