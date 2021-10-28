import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/accounts_modal_content.dart';
import 'package:flutter_application_1/utils/modal.dart';
import 'package:flutter_application_1/utils/setting_widget.dart';

import '../global.dart';

class DrawerProfil extends StatelessWidget {
  const DrawerProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double offset;
    int redditAge = (DateTime.now().millisecondsSinceEpoch ~/ 1000 -
            Global.redditor!.data!["created_utc"].toInt()) ~/
        86400;
    Global.redditor!.data!['subreddit']['public_description'] == null ||
            Global.redditor!.data!['subreddit']['public_description'] == ""
        ? offset = -Global.screenHeight / 16
        : offset = 0;
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Column(
                children: [
                  Global.redditor!.data!['snoovatar_img'] != null &&
                          Global.redditor!.data!['snoovatar_img'] != ""
                      ? SizedBox(height: Global.screenHeight / 15)
                      : SizedBox(height: Global.screenHeight / 100),
                  Global.redditor!.data!['snoovatar_img'] != null &&
                          Global.redditor!.data!['snoovatar_img'] != ""
                      ? SizedBox(
                          child: Container(
                            width: Global.screenWidth / 1.7,
                            height: Global.screenWidth / 2.1,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Transform.translate(
                                offset: Offset(0.0, -Global.screenHeight / 15),
                                child: Image.network(
                                  Global.redditor!.data!['snoovatar_img'],
                                  width: Global.screenWidth / 3,
                                  height: Global.screenHeight / 3.1,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(
                            Global.screenWidth / 30,
                            0.0,
                            Global.screenWidth / 30,
                            0,
                          ),
                          child: Image.asset("assets/user_placeholder.jpeg"),
                        ),
                  Transform.translate(
                    offset: Offset(0.0, -Global.screenHeight / 13),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          Global.screenWidth / 15,
                          0.0,
                          Global.screenWidth / 15,
                          0,
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              Colors.grey.shade300,
                            ),
                          ),
                          onPressed: () {
                            showAccountsModal(
                                context, const AccountsModalContent());
                          },
                          child: Row(
                            children: [
                              const Spacer(flex: 2),
                              Text(
                                "u/" + Global.redditor!.displayName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Global.screenWidth / 26,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: Global.screenWidth / 20,
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0.0, -Global.screenHeight / 30),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(Global.screenWidth / 20, 0.0,
                          Global.screenWidth / 20, Global.screenHeight / 35),
                      child: Text(
                        Global.redditor!.data!['subreddit']
                            ['public_description'],
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: Global.screenHeight / 45,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, offset),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            const Spacer(flex: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.stream_sharp,
                                  color: Colors.blue.shade800,
                                  size: Global.minScreenSize / 13,
                                ),
                                SizedBox(
                                  width: Global.screenWidth / 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Global.redditor!.data!["total_karma"]
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Global.minScreenSize / 20,
                                      ),
                                    ),
                                    Text(
                                      "Karma",
                                      style: TextStyle(
                                        fontSize: Global.minScreenSize / 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            const VerticalDivider(
                              color: Colors.black38,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.cake_sharp,
                                  color: Colors.blue.shade800,
                                  size: Global.minScreenSize / 13,
                                ),
                                SizedBox(
                                  width: Global.screenWidth / 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      redditAge.toString() + "d",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Global.minScreenSize / 20),
                                    ),
                                    Text(
                                      "Reddit age",
                                      style: TextStyle(
                                          fontSize: Global.minScreenSize / 35),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, offset),
                      child: Divider(
                        indent: Global.screenWidth / 20,
                        endIndent: Global.screenWidth / 20,
                        color: Colors.black26,
                      ),
                    ),
                    const SettingWidget(
                      text: "Show NSFW content \n(I'm over 18)",
                      icon: Icons.person_outline_sharp,
                      jsonKey: "over_18",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
