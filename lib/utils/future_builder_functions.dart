import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter_application_1/utils/subreddit_list_content.dart';

import '../global.dart';

class FutureBuilderFunctions {
  static Future<List<SubredditListContent>> getSubredditsList(int limit) async {
    List<SubredditListContent> subredditList = <SubredditListContent>[];
    Stream<SubredditRef> streamList =
        Global.reddit!.user.subreddits(limit: limit);
    await streamList.forEach((element) {
      inspect(element);
      (element as Subreddit);
      if (element.displayName != "Home") {
        subredditList.add(SubredditListContent(
          element: element,
          title: "r/" + element.displayName,
          iconUrl: element.iconImage.toString() == "" ||
                  element.iconImage == null
              ? Uri.parse((element.data!["community_icon"])
                  .substring(0, (element.data!["community_icon"]).indexOf('?')))
              : element.iconImage,
        ));
      }
    });
    return subredditList;
  }
}
