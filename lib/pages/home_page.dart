import 'dart:developer';
import 'dart:math';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _oauth2() async {
    Uuid uuid = const Uuid();
    String userAgent = uuid.v1();

    Reddit reddit = Reddit.createInstalledFlowInstance(
      userAgent: userAgent,
      clientId: 'h-leSR3fD6gG3C6hL2mqBw',
      redirectUri: Uri.parse('redditech://callback'),
    );

    Uri authUrl = reddit.auth.url(['*'], userAgent, compactLogin: true);

    try {
      String result = await FlutterWebAuth.authenticate(
          url: authUrl.toString(), callbackUrlScheme: "redditech");
      String? code = Uri.parse(result).queryParameters['code'];
      await reddit.auth.authorize(code!);
      Global.reddit = reddit;
      Global.redditor = await reddit.user.me();
      inspect(Global.redditor);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/hub');
    } catch (e) {
      throw "User closed auth";
    }
  }

  @override
  Widget build(BuildContext context) {
    Global.screenWidth = MediaQuery.of(context).size.width;
    Global.screenHeight = MediaQuery.of(context).size.height;
    Global.minScreenSize = min(Global.screenHeight, Global.screenWidth);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: Global.screenHeight / 3,
              color: Theme.of(context).colorScheme.primary,
              child: Center(
                  child: SafeArea(
                child: Column(
                  children: [
                    const Spacer(flex: 4),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/redditech_logo.png',
                        width: Global.minScreenSize / 5,
                        height: Global.minScreenSize / 5,
                      ),
                      radius: Global.minScreenSize / 8,
                    ),
                    const Spacer(),
                    Text(
                      'Redditech',
                      style: TextStyle(
                        fontFamily: 'VAG',
                        fontSize: Global.minScreenSize / 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 4),
                  ],
                ),
              )),
            ),
          ),
          const Spacer(flex: 10),
          Text(
            "Welcome to the most insane Redditech!",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: Global.minScreenSize / 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(flex: 2),
          TextButton(
            onPressed: _oauth2,
            child: SizedBox(
              width: Global.screenWidth / 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(flex: 4),
                  Text(
                    "Sign in",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: Global.minScreenSize / 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded),
                  const Spacer(flex: 4),
                ],
              ),
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          const Spacer(flex: 8),
          ClipPath(
            clipper: WaveClipperTwo(reverse: true),
            child: Container(
              height: Global.screenHeight / 5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
