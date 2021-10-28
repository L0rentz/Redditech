import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class JoinQuitButton extends StatefulWidget {
  const JoinQuitButton({Key? key, required this.element}) : super(key: key);

  final Subreddit element;

  @override
  _JoinQuitButtonState createState() => _JoinQuitButtonState();
}

class _JoinQuitButtonState extends State<JoinQuitButton> {
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
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, Global.screenWidth / 80, 0.0),
      width: Global.screenWidth / 8,
      height: Global.screenHeight / 23,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.blue.shade100)),
        onPressed: () {
          onQuitOrJoin(buttonText);
        },
        child: FittedBox(
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
