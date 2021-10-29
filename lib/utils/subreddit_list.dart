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
    required this.filter,
    required this.search,
    required this.refreshCallback,
    this.element,
  }) : super(key: key);

  final Function futureFunction;
  final int limit;
  final Subreddit? element;
  final String filter;
  final String? search;
  final Function? refreshCallback;

  @override
  _SubredditListState createState() => _SubredditListState();
}

class _SubredditListState extends State<SubredditList> {
  final ScrollController _scrollController = ScrollController();

  bool _isFetchLoading = false;
  bool _nothingToDisplay = false;
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
            widget.limit, widget.filter, widget.search)
        : _list = await widget.futureFunction(
            widget.limit, widget.element, widget.filter, widget.search);

    if (!mounted) return;
    setState(() {
      if (_list.isEmpty) {
        _nothingToDisplay = true;
      }
    });
  }

  void getListNext() async {
    if (!mounted) return;
    setState(() {
      _isFetchLoading = true;
    });

    List<dynamic> nextPage = [];
    widget.element == null
        ? nextPage = await widget.futureFunction(
            widget.limit, widget.filter, widget.search,
            after: Global.afterSubreddit)
        : nextPage = await widget.futureFunction(
            widget.limit, widget.element, widget.filter, widget.search,
            after: Global.afterPost);
    _list.addAll(nextPage);

    if (!mounted) return;
    setState(() {
      _isFetchLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _nothingToDisplay
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    foregroundDecoration: const BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                    height: Global.screenWidth / 5,
                    width: Global.screenWidth / 5,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.network(
                        "https://cryptologos.cc/logos/shiba-inu-shib-logo.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Global.screenHeight / 60,
                ),
                Text(
                  "Wow, such empty",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: Global.screenHeight / 60,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          )
        : _list.isEmpty
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
