import 'dart:ui';

import 'package:flutter/material.dart';

import '../global.dart';

Future<dynamic> showAccountsModal(BuildContext context, Widget modalContent) {
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
          height: Global.screenHeight / 9.5,
          child: Wrap(children: [modalContent]),
        ),
      ),
    ),
  );
}
