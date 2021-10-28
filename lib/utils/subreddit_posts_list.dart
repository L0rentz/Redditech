import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/refresher.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../global.dart';

class PostLists extends StatefulWidget {
  const PostLists(
      {Key? key,
      required this.futureFunction,
      required this.limit,
      required this.iconUrl,
      required this.name,
      required this.bannerUrl,
      required this.element,
      required this.refreshCallback})
      : super(key: key);

  final Function futureFunction;
  final String iconUrl;
  final String name;
  final String bannerUrl;
  final int limit;
  final Subreddit element;
  final Function refreshCallback;

  @override
  _PostListsState createState() => _PostListsState();
}

class _PostListsState extends State<PostLists> {
  // Expanded principalStack(AsyncSnapshot<List<dynamic>> snapshot) {
  //   return Expanded(
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           width: Global.screenWidth,
  //           height: Global.screenHeight * 0.08,
  //           child: FittedBox(
  //             fit: BoxFit.fill,
  //             child: Image.network(widget.bannerUrl),
  //           ),
  //         ),
  //         NamedAvatar(iconUrl: widget.iconUrl, name: "r/" + widget.name),
  //         // Transform.translate(
  //         //   offset: Offset(0, Global.minScreenSize * 0.22),
  //         //   child: SizedBox(
  //         //     width: Global.screenWidth,
  //         //     height: Global.screenHeight * 0.08,
  //         //     child: Container(
  //         //       color: Colors.red,
  //         //     ),
  //         //   ),
  //         // ),
  //         ListView.builder(
  //           itemCount: snapshot.data!.length,
  //           itemBuilder: (context, index) {
  //             dynamic element = snapshot.data![index];
  //             return element;
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.futureFunction(widget.limit, widget.element),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Refresher(
            refreshCallback: widget.refreshCallback,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                dynamic element = snapshot.data![index];
                return element;
              },
            ),
          );
        } else {
          return Center(
            child: SizedBox(
              height: Global.minScreenSize / 5,
              width: Global.minScreenSize / 5,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
              ),
            ),
          );
        }
      },
    );
  }
}
