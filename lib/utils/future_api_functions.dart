import 'package:draw/draw.dart';
import 'package:flutter_application_1/utils/subreddit_list_content.dart';
import 'package:flutter_application_1/utils/subreddit_post_content.dart';

import '../global.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FutureApiFunctions {
  static Future<List<SubredditListContent>> getSubredditsList(
      int limit, Function popRefreshCallback, String filter,
      {String after = ""}) async {
    List<SubredditListContent> subredditList = <SubredditListContent>[];
    Stream<SubredditRef> streamList;
    if (filter == "My Subreddits") {
      streamList = Global.reddit!.user.subreddits(limit: 20);
    } else if (filter == "Gold") {
      streamList = Global.reddit!.subreddits
          .gold(limit: limit, params: {"after": after});
    } else if (filter == "Popular") {
      streamList = Global.reddit!.subreddits
          .popular(limit: limit, params: {"after": after});
    } else {
      streamList = Global.reddit!.user.subreddits(limit: 20);
    }
    int idx = 0;
    await streamList.forEach((element) {
      (element as Subreddit);
      if (idx == limit - 1) {
        Global.afterSubreddit = element.fullname;
      }
      subredditList.add(SubredditListContent(
        popRefreshCallback: popRefreshCallback,
        element: element,
        title: "r/" + element.displayName,
        iconUrl: element.iconImage.toString() == "" || element.iconImage == null
            ? element.data!["community_icon"] == "" ||
                    element.data!["community_icon"] == null
                ? Uri.parse("https://i.redd.it/u87eaol1sqi21.png")
                : Uri.parse((element.data!["community_icon"]).substring(
                    0, (element.data!["community_icon"]).indexOf('?')))
            : element.iconImage,
      ));
      idx++;
    });
    return subredditList;
  }

  static Future<List<PostContent>> getPostsFromSubreddit(
      int limit, Subreddit sub, String filter,
      {String after = ""}) async {
    List<PostContent> postList = <PostContent>[];
    Stream<UserContent> postListData;
    if (filter == "Top posts") {
      postListData = sub.top(limit: limit, params: {"after": after});
    } else if (filter == "Hottest") {
      postListData = sub.hot(limit: limit, params: {"after": after});
    } else if (filter == "Newest") {
      postListData = sub.newest(limit: limit, params: {"after": after});
    } else if (filter == "Controversial") {
      postListData = sub.controversial(limit: limit, params: {"after": after});
    } else if (filter == "Rising") {
      postListData = sub.rising(limit: limit, params: {"after": after});
    } else if (filter == "Random") {
      postListData = sub.randomRising(limit: limit, params: {"after": after});
    } else {
      postListData = sub.newest(limit: limit, params: {"after": after});
    }
    int idx = 0;
    await postListData.forEach((element) {
      (element as Submission);
      if (idx == limit - 1) {
        Global.afterPost = element.fullname;
      }
      postList.add(PostContent(
        element: element,
      ));
      idx++;
    });
    return postList;
  }

  static Future<void> updateUserSettings(String jsonKey, dynamic value) async {
    const String url = "https://oauth.reddit.com/api/v1/me/prefs";
    String? authToken = Global.reddit!.auth.credentials.accessToken;
    Object obj = {jsonKey: value};
    await http.patch(
      Uri.parse(url),
      body: json.encode(obj),
      headers: {"Authorization": "bearer $authToken"},
    ).then((value) async {
      Global.redditor = await Global.reddit!.user.me();
      print(value.body);
    });
  }
}
