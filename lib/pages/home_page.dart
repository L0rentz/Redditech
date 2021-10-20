import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:uuid/uuid.dart';

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
        redirectUri: Uri.parse('redditech://callback'));

    // Build the URL used for authentication. See `WebAuthenticator`
    // documentation for parameters.
    final auth_url = reddit.auth.url(['*'], userAgent, compactLogin: true);

    print(auth_url);

    final result = await FlutterWebAuth.authenticate(
        url: auth_url.toString(), callbackUrlScheme: "redditech");

    print(result);
    final code = Uri.parse(result).queryParameters['code'];

    await reddit.auth.authorize(code!);

    print(await reddit.user.me());

    Global.reddit = reddit;

    Navigator.pushNamed(context, '/hub');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Redditech',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                child: Image.asset('assets/redditech_logo.png'),
                width: screenWidth,
                height: screenHeight * 0.25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
              child: TextButton(
                onPressed: _test,
                child: Text(
                  "Sign in",
                  style: Theme.of(context).textTheme.button,
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.grey,
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.13, 0, screenWidth * 0.13, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
