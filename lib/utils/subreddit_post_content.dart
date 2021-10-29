import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global.dart';

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
    String url = widget.element.thumbnail.toString();

    if (!url.contains("http")) {
      url = "";
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Global.screenWidth * 0.03,
            Global.screenWidth * 0.02,
            Global.screenWidth * 0.03,
            Global.screenWidth * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "u/" + widget.element.author + " . " + getPostAge(redditAge),
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: Global.screenWidth * 0.03),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(top: Global.screenWidth * 0.02),
                    child: Text(
                      widget.element.title,
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: Global.screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (url != "") ...[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Global.screenWidth * 0.03),
                      child: SizedBox(
                        width: Global.screenWidth * 0.3,
                        height: Global.screenHeight * 0.15,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(
                            widget.element.thumbnail.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: Global.screenHeight * 0.024,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_downward,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(Global.screenWidth * 0.01,
                            0, Global.screenWidth * 0.01, 0),
                        child: Text(NumberFormat.compactCurrency(
                                decimalDigits: 0, symbol: '')
                            .format(widget.element.score)),
                      ),
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(Global.screenWidth * 0.2,
                            0, Global.screenWidth * 0.03, 0),
                        child: const Icon(
                          Icons.comment_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      Text(NumberFormat.compactCurrency(
                              decimalDigits: 0, symbol: '')
                          .format(widget.element.numComments)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
