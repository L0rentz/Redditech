import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/posts_page.dart';
import 'package:flutter_application_1/utils/filter_button.dart';
import 'package:flutter_application_1/utils/future_api_functions.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/modal_button_selector.dart';
import 'package:flutter_application_1/utils/subreddit_list.dart';

import '../global.dart';

class MyHubPage extends StatefulWidget {
  const MyHubPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  MyHubPageState createState() => MyHubPageState();
}

class MyHubPageState extends State<MyHubPage> {
  String btnText = "My Subreddits";
  String? search;
  IconData btnIcon = Icons.workspaces_outlined;

  void filterCallback(String filter, IconData icon) {
    Navigator.pop(context);
    setState(() {
      btnText = filter;
      search = null;
      btnIcon = icon;
    });
  }

  Column modalContent() {
    return Column(
      children: [
        ModalButtonSelector(
          buttonText: "My Subreddits",
          callback: filterCallback,
          icon: Icons.workspaces_outlined,
        ),
        ModalButtonSelector(
          buttonText: "Popular",
          callback: filterCallback,
          icon: Icons.people_alt_outlined,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SubredditPostArguments;

    if (args.search != null) {
      btnText = args.search!;
      search = args.search!;
      args.search = null;
    }

    return LoggedScaffold(
      body: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                Global.screenWidth * 0.02,
                Global.screenWidth * 0.02,
                0.0,
                Global.screenWidth * 0.01,
              ),
              child: FilterButton(
                filter: btnText,
                icon: search == null ? btnIcon : Icons.search,
                modalContent: modalContent(),
                modalTitle: "SORT SUBREDDITS BY",
              ),
            ),
            Expanded(
              child: SubredditList(
                search: search,
                filter: btnText,
                futureFunction: FutureApiFunctions.getSubredditsList,
                limit: 15,
                key: UniqueKey(),
              ),
            ),
          ],
        );
      }),
      title: widget.title,
    );
  }
}
