import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/pages/posts_page.dart';

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
  String buttonText = "";

  onQuitOrJoin(String text) {
    if (text == "Join") {
      widget.element.subscribe();
      widget.element.data!["user_is_subscriber"] = "true";
      text = "Quit";
    } else {
      widget.element.unsubscribe();
      widget.element.data!["user_is_subscriber"] = "false";
      text = "Join";
    }
    setState(() {
      buttonText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    buttonText = widget.element.data!["user_is_subscriber"].toString() == "true"
        ? "Quit"
        : "Join";

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/posts',
            arguments: SubredditPostArguments(
                widget.element, widget.popRefreshCallback));
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
              TextButton(
                onPressed: () {
                  onQuitOrJoin(buttonText);
                },
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
