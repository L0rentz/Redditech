import 'package:flutter/material.dart';
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
  _MyHubPageState createState() => _MyHubPageState();
}

class _MyHubPageState extends State<MyHubPage> {
  String btnText = "My Subreddits";
  IconData btnIcon = Icons.workspaces_outlined;

  void refreshCallback() {
    setState(() {});
  }

  void filterCallback(String filter, IconData icon) {
    Navigator.pop(context);
    setState(() {
      btnText = filter;
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
                icon: btnIcon,
                modalContent: modalContent(),
                modalTitle: "SORT SUBREDDITS BY",
              ),
            ),
            Expanded(
              child: SubredditList(
                filter: btnText,
                futureFunction: FutureApiFunctions.getSubredditsList,
                limit: 15,
                refreshCallback: refreshCallback,
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
