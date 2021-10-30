import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/pages/hub_page.dart';

class Global {
  static late Reddit? reddit;
  static late Redditor? redditor;
  static late Subreddit? subreddit;
  static late double screenHeight;
  static late double screenWidth;
  static late double minScreenSize;
  static late String? afterPost;
  static late String? afterPostSearch;
  static late String? afterSubreddit;
  static late GlobalKey<MyHubPageState> hubPageKey;
}
