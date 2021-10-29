import 'dart:ui';

import 'package:flutter/material.dart';

import '../global.dart';

Future<dynamic> showAccountsModal(
    BuildContext context, Widget modalContent, String title) {
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
            color: Theme.of(context).cardColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 10,
                blurRadius: 5,
              ),
            ],
          ),
          width: Global.screenWidth,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Global.screenWidth / 30,
              Global.screenHeight / 100,
              Global.screenWidth / 30,
              Global.screenHeight / 100,
            ),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Global.screenHeight / 65,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      color: Colors.black26,
                    ),
                    modalContent,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
