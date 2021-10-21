import 'package:flutter/material.dart';

class SubredditListContent extends StatelessWidget {
  const SubredditListContent(
      {Key? key, required this.title, required this.iconUrl})
      : super(key: key);

  final String title;
  final Uri? iconUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: Row(
        children: [
          if (iconUrl == null || iconUrl.toString() == "") ...[
            Image.asset("assets/placeholder.png"),
          ] else ...[
            Image.network(iconUrl.toString()),
          ],
          const Spacer(),
          Text(title),
          const Spacer(),
        ],
      ),
    );
  }
}
