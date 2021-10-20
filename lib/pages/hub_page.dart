import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SubredditList(
          futureApiCall: Global.reddit!.subreddits.popular,
          limit: 20,
        ),
      ),
    );
  }
}
