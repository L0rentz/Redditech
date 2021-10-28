import 'package:draw/draw.dart';
import 'package:flutter_application_1/utils/subreddit_list_content.dart';
import 'package:flutter_application_1/utils/subreddit_post_content.dart';

import '../global.dart';

class FutureBuilderFunctions {
  static Future<List<SubredditListContent>> getSubredditsList(int limit,
      {String after = ""}) async {
    List<SubredditListContent> subredditList = <SubredditListContent>[];
    Stream<SubredditRef> streamList = Global.reddit!.subreddits
        .popular(limit: limit, params: {"after": after});
    int idx = 0;
    await streamList.forEach((element) {
      (element as Subreddit);
      if (idx == limit - 1) {
        Global.afterSubreddit = element.fullname;
      }
      if (element.displayName != "Home") {
        subredditList.add(SubredditListContent(
          element: element,
          title: "r/" + element.displayName,
          iconUrl:
              element.iconImage.toString() == "" || element.iconImage == null
                  ? element.data!["community_icon"] == "" ||
                          element.data!["community_icon"] == null
                      ? Uri.parse("https://i.redd.it/u87eaol1sqi21.png")
                      : Uri.parse((element.data!["community_icon"]).substring(
                          0, (element.data!["community_icon"]).indexOf('?')))
                  : element.iconImage,
        ));
      }
      idx++;
    });
    return subredditList;
  }

  static Future<List<PostContent>> getPostsFromSubreddit(
      int limit, Subreddit sub,
      {String after = ""}) async {
    List<PostContent> postList = <PostContent>[];
    Stream<UserContent> postListData =
        sub.newest(limit: limit, params: {"after": after});
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
}
