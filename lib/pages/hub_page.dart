import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class MyHubPage extends StatefulWidget {
  const MyHubPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHubPageState createState() => _MyHubPageState();
}

class _MyHubPageState extends State<MyHubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
    );
  }
}
