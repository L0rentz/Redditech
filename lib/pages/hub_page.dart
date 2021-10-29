import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/future_api_functions.dart';
import 'package:flutter_application_1/utils/logged_scaffold.dart';
import 'package:flutter_application_1/utils/modal.dart';
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

  void refreshCallback() {
    setState(() {});
  }

  Container modalButton(String text) {
    return Container(
      margin: EdgeInsets.all(Global.screenWidth / 80),
      width: Global.screenWidth,
      height: Global.screenHeight / 23,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            btnText = text;
          });
        },
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Column modalContent() {
    return Column(
      children: [
        modalButton("My Subreddits"),
        modalButton("Gold"),
        modalButton("Popular")
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
              padding: EdgeInsets.all(Global.screenWidth * 0.02),
              child: GestureDetector(
                onTap: () {
                  showAccountsModal(context, modalContent());
                },
                child: Row(
                  children: [
                    Text(btnText),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: Global.screenWidth / 20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
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
