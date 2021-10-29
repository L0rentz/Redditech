import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/pages/posts_page.dart';
import 'package:flutter_application_1/utils/join_quit_button.dart';

class SubredditListContent extends StatefulWidget {
  const SubredditListContent({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.element,
    required this.popRefreshCallback,
  }) : super(key: key);

  final String title;
  final Uri? iconUrl;
  final Subreddit element;
  final Function popRefreshCallback;

  @override
  State<SubredditListContent> createState() => _SubredditListContentState();
}

class _SubredditListContentState extends State<SubredditListContent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/posts',
            arguments: SubredditPostArguments(
                widget.element, widget.popRefreshCallback, "My Subreddits"));
      },
      child: Card(
        child: SizedBox(
          height: Global.screenHeight / 15,
          child: Row(
            children: [
              const Spacer(),
              if (widget.iconUrl == null ||
                  widget.iconUrl.toString() == "") ...[
                CircleAvatar(
                  radius: Global.screenHeight / 40,
                  backgroundImage: const AssetImage("assets/placeholder.png"),
                ),
              ] else ...[
                CircleAvatar(
                  radius: Global.screenHeight / 40,
                  backgroundImage: NetworkImage(widget.iconUrl.toString()),
                ),
              ],
              const Spacer(flex: 1),
              SizedBox(
                width: Global.screenWidth / 1.5,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: Global.screenHeight / 48,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              const Spacer(flex: 2),
              JoinQuitButton(element: widget.element),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
