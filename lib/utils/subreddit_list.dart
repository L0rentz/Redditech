import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SubredditList extends StatefulWidget {
  const SubredditList({Key? key, required this.futureApiCall, this.limit = 1})
      : super(key: key);

  final Function futureApiCall;
  final int limit;

  @override
  _SubredditListState createState() => _SubredditListState();
}

class _SubredditListState extends State<SubredditList> {
  Future<List<SubredditListContent>> getSubredditList() async {
    List<SubredditListContent> subredditList = <SubredditListContent>[];
    Stream<SubredditRef> streamList = widget.futureApiCall(limit: widget.limit);
    await streamList.forEach((element) {
      inspect(element);
      subredditList.add(SubredditListContent(title: element.displayName));
    });
    return subredditList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SubredditListContent>>(
      future: getSubredditList(),
      builder: (BuildContext context,
          AsyncSnapshot<List<SubredditListContent>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              SubredditListContent element = snapshot.data![index];
              return element;
            },
          );
        } else {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
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

class SubredditListContent extends StatelessWidget {
  const SubredditListContent({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: Row(
        children: [
          Image.asset("assets/placeholder.png"),
          const Spacer(),
          Text(title),
          const Spacer(),
        ],
      ),
    );
  }
}
