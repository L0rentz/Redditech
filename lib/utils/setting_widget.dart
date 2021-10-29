import 'package:flutter/material.dart';
import 'future_api_functions.dart';

import '../global.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget(
      {Key? key,
      required this.text,
      required this.icon,
      required this.jsonKey,
      required this.getBool})
      : super(key: key);

  final String text;
  final IconData icon;
  final String jsonKey;
  final bool? getBool;

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Icon(
          widget.icon,
          size: Global.screenHeight / 28,
        ),
        SizedBox(
          width: Global.screenWidth / 2.8,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Global.screenWidth / 30,
              0.0,
              Global.screenWidth / 30,
              0.0,
            ),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Global.screenHeight / 65,
              ),
            ),
          ),
        ),
        Switch(
          activeColor: Theme.of(context).primaryColor,
          value: widget.getBool!,
          onChanged: (value) async {
            await FutureApiFunctions.updateUserSettings(widget.jsonKey, value);
            if (mounted) {
              setState(() {});
            }
          },
        ),
        const Spacer(),
      ],
    );
  }
}
