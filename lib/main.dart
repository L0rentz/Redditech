import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
String randomStr = uuid.v1();

final _url =
    'https://www.reddit.com/api/v1/authorize?client_id=h-leSR3fD6gG3C6hL2mqBw&response_type=code&state=' +
        randomStr +
        '&redirect_uri=http://localhost/:8080&duration=temporary&scope=identity%27)';

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
    const userAgent = 'foobarHGFHGFGHFGHFGH';

    // Create a `Reddit` instance using a configuration file in the current
    // directory. Unlike the web authentication example, a client secret does
    // not need to be provided in the configuration file.
    final reddit = Reddit.createInstalledFlowInstance(
        userAgent: userAgent,
        clientId: 'h-leSR3fD6gG3C6hL2mqBw',
        redirectUri: Uri.parse('redditech://hello'));

    // Build the URL used for authentication. See `WebAuthenticator`
    // documentation for parameters.
    final auth_url = reddit.auth.url(['*'], 'foobar');

    print(auth_url);

    final result = await FlutterWebAuth.authenticate(
        url: auth_url.toString(), callbackUrlScheme: "redditech");

// Extract token from resulting url
    // final token = Uri.parse(result).queryParameters['token'];
    // ...
    // Complete authentication at `auth_url` in the browser and retrieve
    // the `code` query parameter from the redirect URL.
    // ...

    // Assuming the `code` query parameter is stored in a variable
    // `auth_code`, we pass it to the `authorize` method in the
    // `WebAuthenticator`.
    // await reddit.auth.authorize(auth_code);

    // If everything worked correctly, we should be able to retrieve
    // information about the authenticated account.
    // print(await reddit.user.me());
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
