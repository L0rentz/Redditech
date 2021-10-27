import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../global.dart';

class Refresher extends StatefulWidget {
  const Refresher(
      {Key? key, required this.child, required this.refreshCallback})
      : super(key: key);

  final Widget child;
  final Function refreshCallback;

  @override
  _RefresherState createState() => _RefresherState();
}

class _RefresherState extends State<Refresher> {
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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(
        waterDropColor: Theme.of(context).primaryColor,
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: widget.child,
    );
  }
}
