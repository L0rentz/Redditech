import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubredditList extends StatefulWidget {
  const SubredditList({
    Key? key,
    required this.futureFunction,
    required this.limit,
    required this.refreshCallback,
  }) : super(key: key);

  final Function futureFunction;
  final int limit;
  final Function refreshCallback;

  @override
  _SubredditListState createState() => _SubredditListState();
}

class _SubredditListState extends State<SubredditList> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Global.reddit!.auth.refresh();
    Global.redditor = await Global.reddit!.user.me();
    widget.refreshCallback();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.futureFunction(widget.limit),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(
              waterDropColor: Theme.of(context).primaryColor,
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
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
