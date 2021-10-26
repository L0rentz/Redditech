import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/drawer_profil.dart';

class LoggedScaffold extends StatelessWidget {
  const LoggedScaffold({Key? key, required this.body, required this.title})
      : super(key: key);

  final Widget body;
  final String title;

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
                            width: Global.screenHeight / 20,
                            height: Global.screenHeight / 20,
                            child: Stack(
                              children: [
                                Transform.translate(
                                  offset: Offset(
                                    -Global.minScreenSize / 110,
                                    Global.screenHeight / 250,
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
          ],
        ),
      ),
      body: body,
    );
  }
}
