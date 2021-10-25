import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SubredditList extends StatefulWidget {
  const SubredditList({
    Key? key,
    required this.futureFunction,
    required this.limit,
  }) : super(key: key);

  final Function futureFunction;
  final int limit;

  @override
  _SubredditListState createState() => _SubredditListState();
}

class _SubredditListState extends State<SubredditList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.futureFunction(widget.limit),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              dynamic element = snapshot.data![index];
              return element;
            },
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
