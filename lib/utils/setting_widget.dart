import 'package:adaptive_theme/adaptive_theme.dart';
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
  late bool? switchBool;

  @override
  void initState() {
    switchBool = widget.getBool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Icon(
          widget.icon,
          size: Global.screenHeight / 28,
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: Global.screenWidth / 2.8,
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Global.screenHeight / 65,
            ),
          ),
        ),
        const Spacer(flex: 2),
        Switch(
          activeColor: Theme.of(context).primaryColor,
          value: switchBool!,
          onChanged: (value) async {
            value == true && widget.jsonKey == "nightmode"
                ? AdaptiveTheme.of(context).setDark()
                : AdaptiveTheme.of(context).setLight();
            await FutureApiFunctions.updateUserSettings(widget.jsonKey, value);
            if (mounted) {
              setState(() {
                switchBool = value;
              });
            }
          },
        ),
        const Spacer(),
      ],
    );
  }
}
