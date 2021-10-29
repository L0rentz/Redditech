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
    return SizedBox(
      width: Global.screenWidth / 9,
      height: Global.screenHeight / 25,
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20.0),
        child: FittedBox(
          fit: BoxFit.fill,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            splashColor: Colors.orangeAccent.shade400,
            onTap: () {
              onQuitOrJoin(buttonText);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
