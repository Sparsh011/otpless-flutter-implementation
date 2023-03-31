import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Continue With Whatsapp"),
              onPressed: () {
                initiateWhatsappLogin(
                  "https://helloworld.authlink.me?redirectUri=helloworldotpless://otpless",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // set the background color to blue
                minimumSize: const Size(250, 50), // set the button's minimum size (width x height)
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // set the button's padding
              ),
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
