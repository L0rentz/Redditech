import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/refresher.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SubredditList extends StatefulWidget {
  const SubredditList({
    Key? key,
    required this.futureFunction,
    required this.limit,
    required this.refreshCallback,
    required this.filter,
    this.element,
  }) : super(key: key);

  final Function futureFunction;
  final int limit;
  final Function refreshCallback;
  final Subreddit? element;
  final String filter;

  @override
  _SubredditListState createState() => _SubredditListState();
}

class _SubredditListState extends State<SubredditList> {
  final ScrollController _scrollController = ScrollController();

  bool _isFetchLoading = false;
  List<dynamic> _list = [];

  @override
  void initState() {
    super.initState();
    getList();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        getListNext();
      }
    });
  }

  void getList() async {
    widget.element == null
        ? _list = await widget.futureFunction(
            widget.limit, widget.refreshCallback, widget.filter)
        : _list = await widget.futureFunction(
            widget.limit, widget.element, widget.filter);

    if (!mounted) return;
    setState(() {});
  }

  void getListNext() async {
    if (!mounted) return;
    setState(() {
      _isFetchLoading = true;
    });

    List<dynamic> nextPage = [];
    widget.element == null
        ? nextPage = await widget.futureFunction(
            widget.limit, widget.refreshCallback, widget.filter,
            after: Global.afterSubreddit)
        : nextPage = await widget.futureFunction(
            widget.limit, widget.element, widget.filter,
            after: Global.afterPost);
    _list.addAll(nextPage);

    if (!mounted) return;
    setState(() {
      _isFetchLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _list.isEmpty
        ? Center(
            child: SizedBox(
              height: Global.minScreenSize / 5,
              width: Global.minScreenSize / 5,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
              ),
            ),
          )
        : Column(
            children: [
              Expanded(
                flex: 11,
                child: Scrollbar(
                  child: Refresher(
                    refreshCallback: widget.refreshCallback,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return _list[index];
                      },
                    ),
                  ),
                ),
              ),
              _isFetchLoading
                  ? Expanded(
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.white,
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(Global.screenHeight / 100),
                              child: const LoadingIndicator(
                                indicatorType: Indicator.ballSpinFadeLoader,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          );
  }
}
