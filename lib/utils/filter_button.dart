import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/modal.dart';

import '../global.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.filter,
    required this.modalContent,
    required this.modalTitle,
    required this.icon,
  }) : super(key: key);

  final String filter;
  final Widget modalContent;
  final String modalTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        onTap: () {
          showAccountsModal(
            context,
            modalContent,
            modalTitle,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: Global.screenWidth / 18,
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                Global.screenWidth * 0.02,
                0.0,
                Global.screenWidth * 0.01,
                0.0,
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: Global.screenHeight / 52,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).primaryColor,
              size: Global.screenWidth / 18,
            ),
          ],
        ),
      ),
    );
  }
}
