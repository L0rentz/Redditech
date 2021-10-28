import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class AccountsModalContent extends StatelessWidget {
  const AccountsModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String iconImg = Global.redditor!.data!['icon_img'];
    int separatorIdx = iconImg.indexOf('?');
    if (separatorIdx != -1) {
      iconImg = iconImg.substring(0, separatorIdx);
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Global.screenWidth / 30,
        Global.screenHeight / 100,
        Global.screenWidth / 30,
        Global.screenHeight / 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ACCOUNTS",
            style: TextStyle(
              fontSize: Global.screenHeight / 65,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const Divider(
            color: Colors.black26,
          ),
          Row(
            children: [
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
                  onTap: () async {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    Navigator.pushNamed(context, '/');
                    Future<SharedPreferences> _prefs =
                        SharedPreferences.getInstance();
                    final SharedPreferences prefs = await _prefs;
                    prefs.remove('credentialsJson');
                    Global.reddit = null;
                    Global.redditor = null;
                  },
                  child: Icon(
                    Icons.exit_to_app_rounded,
                    size: Global.screenHeight / 30,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
