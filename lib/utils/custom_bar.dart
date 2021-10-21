import 'dart:async';

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.isTop,
      required this.isNeg,
      required this.screenWidth})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  final bool isTop;
  final double isNeg;
  final double screenWidth;

  @override
  Size get preferredSize => const Size.fromHeight(40);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late Timer _everySecond;
  late double posX;

  @override
  void initState() {
    super.initState();
    if (widget.isTop) {
      posX = widget.screenWidth + 250;
    } else {
      posX = widget.screenWidth - 250;
    }

    _everySecond = Timer.periodic(const Duration(milliseconds: 5), (Timer t) {
      setState(() {
        if (widget.isTop) {
          posX += 1;
        } else {
          posX -= 1;
        }
        if (posX > widget.screenWidth + 250) posX = -249;
        if (posX < (widget.screenWidth * -1) - 250)
          posX = widget.screenWidth + 249;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: UniqueKey(),
      shape: CustomShapeBorder(widget.isNeg, widget.isTop, posX),
    );
  }

  // Size get preferredSize => const Size.fromHeight(40);
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  final double isNeg;
  final bool isTop;
  final double posX;

  const CustomShapeBorder(this.isNeg, this.isTop, this.posX);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    print(posX);
    double x, y, r;
    Path path;
    if (isTop) {
      x = 150;
      y = 75 * isNeg;
      r = 0.5;
      path = Path()
        ..addRRect(RRect.fromRectAndCorners(rect))
        ..moveTo(rect.bottomRight.dx - posX, rect.bottomCenter.dy)
        ..relativeQuadraticBezierTo(
            ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * r, y * r)
        ..relativeQuadraticBezierTo(
            -x / 6 * r, y * (1 - r), -x / 2 * (1 - r), y * (1 - r))
        ..relativeQuadraticBezierTo(
            ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * (1 - r), -y * (1 - r))
        ..relativeQuadraticBezierTo(-x / 6 * r, -y * r, -x / 2 * r, -y * r);
      path.close();
    } else {
      x = 150;
      y = 75 * isNeg;
      r = 0.5;
      path = Path()
        ..addRRect(RRect.fromRectAndCorners(rect))
        ..moveTo(rect.topCenter.dx - posX, rect.topCenter.dy)
        ..relativeQuadraticBezierTo(
            ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * r, y * r)
        ..relativeQuadraticBezierTo(
            -x / 6 * r, y * (1 - r), -x / 2 * (1 - r), y * (1 - r))
        ..relativeQuadraticBezierTo(
            ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * (1 - r), -y * (1 - r))
        ..relativeQuadraticBezierTo(-x / 6 * r, -y * r, -x / 2 * r, -y * r);
      path.close();
    }
    return path;
  }
}
