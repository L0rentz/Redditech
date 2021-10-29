import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/filter_button.dart';
import 'package:flutter_application_1/utils/future_api_functions.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/modal_button_selector.dart';
import 'package:flutter_application_1/utils/named_avatar.dart';
import 'package:flutter_application_1/utils/subreddit_list.dart';

import '../global.dart';

class SubredditPostArguments {
  final Subreddit? element;
  String? search;
  bool? willPop;
  Key? hubPageKey;

  SubredditPostArguments(
      this.element, this.search, this.willPop, this.hubPageKey);
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  String btnText = "Newest";
  String? search;
  IconData btnIcon = Icons.new_releases_outlined;

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

  Column modalContent() {
    return Column(
      children: [
        ModalButtonSelector(
          buttonText: "Hottest",
          callback: filterCallback,
          icon: Icons.local_fire_department_sharp,
        ),
        ModalButtonSelector(
          buttonText: "Newest",
          callback: filterCallback,
          icon: Icons.new_releases_outlined,
        ),
        ModalButtonSelector(
          buttonText: "Top posts",
          callback: filterCallback,
          icon: Icons.emoji_events_outlined,
        ),
        ModalButtonSelector(
          buttonText: "Controversial",
          callback: filterCallback,
          icon: Icons.call_split_sharp,
        ),
        ModalButtonSelector(
          buttonText: "Rising",
          callback: filterCallback,
          icon: Icons.trending_up_sharp,
        ),
        ModalButtonSelector(
          buttonText: "Random",
          callback: filterCallback,
          icon: Icons.wifi_protected_setup_sharp,
        ),
      ],
    );
  }

  void filterCallback(String filter, IconData icon) {
    Navigator.pop(context);
    setState(() {
      btnText = filter;
      search = null;
      btnIcon = icon;
    });
  }

  void refreshCallback() {
    setState(() {});
    print('ass');
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SubredditPostArguments;

    if (args.search != null) {
      btnText = args.search!;
      search = args.search;
      args.search = null;
    }

    final String rawBannerUrl = args.element!.data!["banner_background_image"];
    String bannerUrl = rawBannerUrl.split("?")[0];
    final Uri? uriIconUrl = args.element!.iconImage.toString() == "" ||
            args.element!.iconImage == null
        ? args.element!.data!["community_icon"] == "" ||
                args.element!.data!["community_icon"] == null
            ? Uri.parse("https://i.redd.it/u87eaol1sqi21.png")
            : Uri.parse((args.element!.data!["community_icon"]).substring(
                0, (args.element!.data!["community_icon"]).indexOf('?')))
        : args.element!.iconImage;
    String iconUrl = uriIconUrl.toString();
    final String description = args.element!.data!["public_description"];

    inspect(args.element);
    if (rawBannerUrl == "") {
      bannerUrl =
          "https://images.squarespace-cdn.com/content/v1/58d0e14c17bffced43369196/1525012335605-81SLLW7QN5YO9R9PTWKY/240_F_101827233_lk3Z4zbgtDLVZTHi2TZLae2zuWHbFsxq.jpg?format=2500w";
    }
    if (iconUrl == "") {
      iconUrl = "https://i.redd.it/u87eaol1sqi21.png";
    }

    Future<bool> _willPopCallback() async {
      Global.hubPageKey.currentState!.setState(() {});
      return true;
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
                  bannerUrl, iconUrl, args.element!.displayName, args.element!),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Global.screenWidth * 0.04,
                  0.0,
                  Global.screenWidth * 0.04,
                  Global.screenWidth * 0.02,
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
                            args.element!.data!["subscribers"].toString() +
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
                    FilterButton(
                      filter: btnText,
                      icon: search == null ? btnIcon : Icons.search,
                      modalContent: modalContent(),
                      modalTitle: "SORT POSTS BY",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SubredditList(
                  search: search,
                  filter: btnText,
                  refreshCallback: refreshCallback,
                  element: args.element,
                  futureFunction: FutureApiFunctions.getPostsFromSubreddit,
                  limit: 20,
                  key: UniqueKey(),
                ),
              ),
            ],
          );
        }),
        title: args.element!.title,
      ),
    );
  }
}
