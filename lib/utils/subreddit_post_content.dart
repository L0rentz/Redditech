import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class PostContent extends StatefulWidget {
  const PostContent({Key? key, required this.element}) : super(key: key);

  final Submission element;
  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  String getPostAge(int time) {
    String ret;
    ret = time.toString() + "min";
    if (time >= 60) {
      time ~/= 60;
      ret = time.toString() + "h";
    } else {
      return (ret);
    }
    if (time >= 24) {
      time ~/= 24;
      ret = time.toString() + "d";
    }
    if (time >= 365) {
      int rett = time % 365;
      time ~/= 365;
      ret = time.toString() + "y " + rett.toString() + "d";
    }
    return (ret);
  }

  @override
  Widget build(BuildContext context) {
    int ass = widget.element.createdUtc.millisecondsSinceEpoch.toInt();
    int redditAge = (DateTime.now().millisecondsSinceEpoch - ass) ~/ 60000;

    return Card(
      child: Column(
        children: [
          Text("Post from: " + widget.element.author),
          Text("Post: " + widget.element.title),
          Text(getPostAge(redditAge))
        ],
      ),
    );
  }
}
