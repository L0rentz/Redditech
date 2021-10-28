import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/future_api_functions.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/subreddit_list.dart';

class MyHubPage extends StatefulWidget {
  const MyHubPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHubPageState createState() => _MyHubPageState();
}

class _MyHubPageState extends State<MyHubPage> {
  void refreshCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoggedScaffold(
      body: Builder(builder: (context) {
        return SubredditList(
          futureFunction: FutureApiFunctions.getSubredditsList,
          limit: 15,
          refreshCallback: refreshCallback,
          key: UniqueKey(),
        );
      }),
      title: widget.title,
    );
  }
}
