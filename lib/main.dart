import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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
  Future<void> _test() async {
    var uuid = const Uuid();
    String userAgent = uuid.v1();

    // Create a `Reddit` instance using a configuration file in the current
    // directory. Unlike the web authentication example, a client secret does
    // not need to be provided in the configuration file.
    final reddit = Reddit.createInstalledFlowInstance(
        userAgent: userAgent,
        clientId: 'h-leSR3fD6gG3C6hL2mqBw',
        tokenEndpoint:
            Uri.parse('https://www.reddit.com/api/v1/authorize.compact'),
        redirectUri: Uri.parse('redditech://callback'));

    // Build the URL used for authentication. See `WebAuthenticator`
    // documentation for parameters.
    final auth_url = reddit.auth.url(['*'], userAgent);

    print(auth_url);

    final result = await FlutterWebAuth.authenticate(
        url:
            'https://www.reddit.com/api/v1/authorize.compact?response_type=code&client_id=h-leSR3fD6gG3C6hL2mqBw&redirect_uri=redditech%3A%2F%2Fcallback&code_challenge=tbFuAXBqDzqUqdrK322pM73ZTvotzGxQHDfiC2nonU8&code_challenge_method=S256&state=foobar&scope=%2A&duration=permanent',
        callbackUrlScheme: "redditech");

    print(result);
    List codeList = result.split("code=");

    await reddit.auth.authorize(codeList[1]);

    print(await reddit.user.me());
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _test,
        tooltip: 'Reddit auth',
        child: const Icon(Icons.add),
      ),
    );
  }
}
