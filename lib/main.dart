import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/pages/hub_page.dart';
import 'package:flutter_application_1/pages/posts_page.dart';
import 'package:flutter_application_1/theme/redditech_colors.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    Global.hubPageKey = GlobalKey<MyHubPageState>();

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: AdaptiveTheme(
        light: ThemeData(
          primarySwatch: Palette.redditOrange,
          backgroundColor: Colors.white,
          hintColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey[100],
          accentColor: Palette.redditOrange,
          canvasColor: Colors.grey.shade300,
          dividerColor: Colors.black38,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        dark: ThemeData(
          primarySwatch: Palette.redditOrange,
          backgroundColor: Colors.black,
          hintColor: Colors.white,
          cardColor: Colors.grey.shade800,
          dividerColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          canvasColor: Colors.black,
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(bodyColor: Colors.white),
          scaffoldBackgroundColor: Colors.black,
          accentColor: Palette.redditOrange,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Redditech',
          theme: theme,
          darkTheme: darkTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(title: "Redditech"),
            '/hub': (context) =>
                MyHubPage(title: "Hub", key: Global.hubPageKey),
            '/posts': (context) => const PostsPage(),
          },
        ),
      ),
    );
  }
}
