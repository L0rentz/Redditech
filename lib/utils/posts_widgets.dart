import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import 'join_quit_button.dart';

class NamedAvatar extends StatefulWidget {
  const NamedAvatar(
      {Key? key,
      required this.iconUrl,
      required this.name,
      required this.element})
      : super(key: key);

  final String iconUrl;
  final String name;
  final Subreddit element;
  @override
  _NamedAvatarState createState() => _NamedAvatarState();
}

class _NamedAvatarState extends State<NamedAvatar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(Global.minScreenSize * 0.06,
              Global.minScreenSize * 0.06, Global.minScreenSize * 0.06, 0),
          width: Global.minScreenSize * 0.12,
          height: Global.minScreenSize * 0.12,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: Global.minScreenSize * 0.005,
            ),
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(widget.iconUrl), fit: BoxFit.fill),
          ),
        ),
        Row(
          children: [
            Padding(
              padding:
                  EdgeInsets.fromLTRB(Global.minScreenSize * 0.06, 0, 0, 0),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: Global.minScreenSize / 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            JoinQuitButton(
              element: widget.element,
            ),
          ],
        ),
      ],
    );
  }
}
