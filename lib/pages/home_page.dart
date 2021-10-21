import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/custom_bar.dart';
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
      //print(await reddit.user.me());
      Global.reddit = reddit;
      Navigator.pushNamed(context, '/hub');
    } catch (e) {
      throw "User closed auth";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        isNeg: 1,
        isTop: true,
        screenWidth: MediaQuery.of(context).size.width,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 5),
            Text(
              'Redditech',
              style: Theme.of(context).textTheme.headline1,
            ),
            const Spacer(),
            SizedBox(
              child: Image.asset('assets/redditech_logo.png'),
              width: screenWidth,
              height: screenHeight * 0.25,
            ),
            const Spacer(),
            TextButton(
              onPressed: _oauth2,
              child: Text(
                "Sign in",
                style: Theme.of(context).textTheme.button,
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.grey,
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.13,
                  0,
                  screenWidth * 0.13,
                  0,
                ),
              ),
            ),
            const Spacer(flex: 5),
            CustomAppBar(
              isNeg: -1,
              isTop: false,
              screenWidth: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
