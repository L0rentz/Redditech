import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hub_page.dart';
import 'package:flutter_application_1/theme/redditech_colors.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Palette.redditOrange,
        scaffoldBackgroundColor: Colors.grey.shade200,
        textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'VAG',
              fontSize: 45,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
                fontFamily: 'OpenSans', fontSize: 18, color: Colors.white)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: "Redditech"),
        '/hub': (context) => const MyHubPage(title: "Home"),
      },
    );
  }
}
