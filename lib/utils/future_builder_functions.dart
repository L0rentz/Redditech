import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter_application_1/utils/subreddit_list_content.dart';

import '../global.dart';

class FutureBuilderFunctions {
  static Future<List<SubredditListContent>> getSubredditsPopularList(
      int limit) async {
    List<SubredditListContent> subredditList = <SubredditListContent>[];
    Stream<SubredditRef> streamList =
        Global.reddit!.subreddits.popular(limit: limit);
    await streamList.forEach((element) {
      inspect(element);
      subredditList.add(SubredditListContent(
        title: element.displayName,
        iconUrl: (element as Subreddit).iconImage,
      ));
    });
    return subredditList;
  }
}
