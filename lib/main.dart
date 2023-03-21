import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // Press ctrl + shift + \ for hot reload
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demoooo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _otplessFlutterPlugin = Otpless();
  String _waId = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

// ** Function that is called when page is loaded
// ** We can check the auth state in this function
  Future<void> initPlatformState() async {
    _otplessFlutterPlugin.authStream.listen((token) {
      setState(() {
        _waId = token ?? "Unknown";
        print(_waId);
// Send the waId to your server and pass the waId in getUserDetail API to retrieve the user detail.
// Handle the signup/sign in process here
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            CupertinoButton.filled(
              child: const Text("Continue With Whatsapp"),
              onPressed: () {
                initiateWhatsappLogin(
                  "https://otpless.authlink.me?redirectUri=otpless://otpless",
                );
              },
            ),
          ],
        ),
      ),
    );
  }



// Continue With WhatsApp function
  void initiateWhatsappLogin(String intentUrl) async {
    var result = await _otplessFlutterPlugin.loginUsingWhatsapp(intentUrl: intentUrl);
    switch (result['code']) {
      case "581":
        print(result['message']);
        break;
      default:
    }
  }
}
