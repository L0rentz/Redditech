import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/future_builder_functions.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/subreddit_list.dart';

import '../global.dart';

class MyHubPage extends StatefulWidget {
  const MyHubPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHubPageState createState() => _MyHubPageState();
}

class _MyHubPageState extends State<MyHubPage> {
  @override
  Widget build(BuildContext context) {
    return LoggedScaffold(
      body: Builder(builder: (context) {
        return SizedBox(
          height: Global.screenHeight,
          child: const SubredditList(
            futureFunction: FutureBuilderFunctions.getSubredditsPopularList,
            limit: 20,
          ),
        );
      }),
      title: widget.title,
    );
  }
}
