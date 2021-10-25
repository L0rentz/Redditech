import 'package:flutter/material.dart';

import '../global.dart';

class DrawerProfil extends StatelessWidget {
  const DrawerProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: Global.screenHeight / 15,
              ),
              Container(
                width: Global.screenWidth / 1.7,
                height: Global.screenWidth / 1.7,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Global.redditor!.data!['snoovatar_img'] != null ||
                            Global.redditor!.data!['snoovatar_img'] != ""
                        ? SizedBox(
                            height: Global.screenWidth / 2.2,
                            child: Center(
                              child: Transform.translate(
                                offset: Offset(0.0, -Global.screenHeight / 18),
                                child: Image.network(
                                    Global.redditor!.data!['snoovatar_img']),
                              ),
                            ),
                          )
                        : Image.asset("assets/user_placeholder.jpeg"),
                    Transform.translate(
                      offset: Offset(0.0, -Global.screenHeight / 32),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            Global.screenWidth / 30,
                            0.0,
                            Global.screenWidth / 30,
                            0,
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                Colors.grey.shade300,
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Spacer(flex: 2),
                                Text(
                                  "u/" + Global.redditor!.displayName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
