import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/pages/hub_page.dart';
import 'package:flutter_application_1/pages/posts_page.dart';
import 'package:flutter_application_1/utils/drawer_profil.dart';

class LoggedScaffold extends StatefulWidget {
  const LoggedScaffold({Key? key, required this.body, required this.title})
      : super(key: key);

  final Widget body;
  final String title;

  @override
  State<LoggedScaffold> createState() => _LoggedScaffoldState();
}

class _LoggedScaffoldState extends State<LoggedScaffold> {
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.grey,
    size: Global.screenWidth * 0.08,
  );
  Widget _appBarTitle = const Text('');

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(
          Icons.close,
          color: Colors.grey,
        );
        _appBarTitle = TextField(
          autofocus: true,
          controller: _filter,
          onSubmitted: (String value) {
            _filter.clear();
            Global.afterPostSearch = "";

            if (ModalRoute.of(context)!.settings.name.toString() == "/hub") {
              Global.hubPageKey = GlobalKey<MyHubPageState>();
              Navigator.pop(context);
              Navigator.pushNamed(
                  context, ModalRoute.of(context)!.settings.name.toString(),
                  arguments: SubredditPostArguments(
                      null, value, null, Global.hubPageKey));
            } else {
              Navigator.popAndPushNamed(
                  context, ModalRoute.of(context)!.settings.name.toString(),
                  arguments: SubredditPostArguments(
                      Global.subreddit, value, true, null));
            }
          },
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: 'Search...'),
        );
      } else {
        _searchIcon = const Icon(
          Icons.search,
          color: Colors.grey,
        );
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: Global.screenWidth / 1.5,
        child: const DrawerProfil(),
      ),
      appBar: AppBar(
        toolbarHeight: Global.screenHeight / 16,
        backgroundColor: Theme.of(context).cardColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Builder(builder: (context) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Global.redditor!.data!['snoovatar_img'] != null &&
                            Global.redditor!.data!['snoovatar_img'] != ""
                        ? SizedBox(
                            width: Global.screenHeight / 18,
                            height: Global.screenHeight / 18,
                            child: Stack(
                              children: [
                                Transform.translate(
                                  offset: Offset(
                                    -Global.minScreenSize / 80,
                                    Global.screenHeight / 200,
                                  ),
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.network(
                                    Global.redditor!.data!['snoovatar_img']),
                              ],
                            ),
                          )
                        : CircleAvatar(
                            radius: Global.screenHeight / 45,
                            backgroundImage: NetworkImage(
                                Global.redditor!.data!['icon_img']),
                          ),
                  ),
                ],
              );
            }),
            Expanded(child: _appBarTitle),
            IconButton(
              onPressed: _searchPressed,
              icon: _searchIcon,
              splashRadius: Global.screenWidth * 0.05,
            ),
          ],
        ),
      ),
      body: widget.body,
    );
  }
}
