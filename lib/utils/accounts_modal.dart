import 'dart:ui';

import 'package:flutter/material.dart';

import '../global.dart';

Future<dynamic> showAccountsModal(BuildContext context) {
  String iconImg = Global.redditor!.data!['icon_img'];
  int separatorIdx = iconImg.indexOf('?');
  if (separatorIdx != -1) {
    iconImg = iconImg.substring(0, separatorIdx);
  }
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (buildContext) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Global.screenWidth / 20,
          0.0,
          Global.screenWidth / 20,
          Global.screenWidth / 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 10,
                blurRadius: 5,
              ),
            ],
          ),
          width: Global.screenWidth,
          height: Global.screenHeight / 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(Global.screenWidth / 30, 0.0, 0.0, 0.0),
                child: Text(
                  "ACCOUNTS",
                  style: TextStyle(
                    fontSize: Global.screenHeight / 65,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Divider(
                color: Colors.black26,
                indent: Global.screenWidth / 30,
                endIndent: Global.screenWidth / 30,
              ),
              Row(
                children: [
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: Global.screenHeight / 50,
                    backgroundImage: NetworkImage(iconImg),
                  ),
                  const Spacer(),
                  Text(
                    "u/" + Global.redditor!.displayName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Global.screenHeight / 50,
                    ),
                  ),
                  const Spacer(flex: 6),
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.exit_to_app_rounded,
                        size: Global.screenHeight / 30,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ),
  );
}
