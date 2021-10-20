import 'dart:async';
import 'dart:developer';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:uuid/uuid.dart';
import 'subreddit_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Redditech'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Reddit reddit;
  bool init = false;

  Future<Reddit> _test() async {
    Uuid uuid = const Uuid();
    String userAgent = uuid.v1();

    // Create a `Reddit` instance using a configuration file in the current
    // directory. Unlike the web authentication example, a client secret does
    // not need to be provided in the configuration file.
    Reddit reddit = Reddit.createInstalledFlowInstance(
        userAgent: userAgent,
        clientId: 'h-leSR3fD6gG3C6hL2mqBw',
        redirectUri: Uri.parse('redditech://callback'));

    // Build the URL used for authentication. See `WebAuthenticator`
    // documentation for parameters.
    Uri authUrl = reddit.auth.url(['*'], userAgent, compactLogin: true);

    String result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(), callbackUrlScheme: "redditech");

    String? code = Uri.parse(result).queryParameters['code'];

    await reddit.auth.authorize(code!);

    //print(await reddit.user.me());
    return reddit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Test Authentification',
            ),
            Text(
              'Auth',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: (() {
                if (init == true) {
                  return SubredditList(
                    futureApiCall: reddit.subreddits.newest,
                    limit: 10,
                  );
                }
              }()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          reddit = await _test();
          setState(() {
            init = true;
          });
        },
        tooltip: 'Reddit auth',
        child: const Icon(Icons.add),
      ),
    );
  }
}
