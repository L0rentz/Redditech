import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: Global.screenWidth / 1.5,
        child: const DrawerProfil(),
      ),
      appBar: AppBar(
        toolbarHeight: Global.screenHeight / 16,
        backgroundColor: Colors.white,
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
            const Spacer(),
          ],
        ),
      ),
      body: widget.body,
    );
  }
}
