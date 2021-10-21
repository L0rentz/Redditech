import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/future_builder_functions.dart';
import 'package:flutter_application_1/utils/subreddit_list.dart';

class MyHubPage extends StatefulWidget {
  const MyHubPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHubPageState createState() => _MyHubPageState();
}

class _MyHubPageState extends State<MyHubPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text(widget.title)),
        ),
        body: Builder(builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                Scaffold.of(context).appBarMaxHeight!,
            child: const SubredditList(
              futureFunction: FutureBuilderFunctions.getSubredditsPopularList,
              limit: 20,
            ),
          );
        }),
      ),
    );
  }
}
