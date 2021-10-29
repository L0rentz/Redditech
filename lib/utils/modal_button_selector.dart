import 'package:flutter/material.dart';

import '../global.dart';

class ModalButtonSelector extends StatelessWidget {
  const ModalButtonSelector(
      {Key? key,
      required this.buttonText,
      required this.callback,
      required this.icon})
      : super(key: key);

  final String buttonText;
  final Function callback;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        onTap: () => callback(buttonText, icon),
        child: Container(
          margin: EdgeInsets.all(Global.screenWidth / 80),
          width: Global.screenWidth,
          height: Global.screenHeight / 23,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: Global.screenWidth / 50),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              FittedBox(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
