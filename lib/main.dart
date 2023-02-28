import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:scancard/DetailCardFragment.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  bool initilized = false;
  String _Number = "";
  String _Email = "";
  String _WebAddress = "";

  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      initilized = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: TextButton(
          onPressed: _read,
          child: Text("Scan card"),
        ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _read() async {
    List<OcrText> list = [];


    try {
      list = await FlutterMobileVision.read(
          waitTap: true,
          multiple: true,
          fps: 13.0,
          camera: 0,

          autoFocus: true,
          scanArea: Size(640, 480),
          showText: false

      );


      setState(() {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailCard(OcrTextt: list)));
      });
    }
    catch (e) {

    }
  }


}

