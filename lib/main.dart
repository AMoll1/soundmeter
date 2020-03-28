import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:audio_streams/audio_streams.dart';
import 'dart:io' show Platform;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application. asfdsdaf
  // Thomas test 1
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundmeter',
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
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Soundmeter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _result;
  bool isRecording;
  Stream<List<int>> stream;
  StreamSubscription<List<int>> listener;
  List<int> currentSamples;
  String status;
  AudioController controller; //IOS
  List<int> finalSamples = [];
  DateTime startTime;



  Future appendCurrent(List<int> test) async {
    //await Future.delayed(Duration(seconds: 1)); //Mock delay
    for (int i = 0; i < test.length; i++) {
      finalSamples.add(test[i]);
    }
  }



  @override
  void initState() {
    super.initState();
    _result = 0.0;
    status = "not running";
    isRecording = false;
    finalSamples = [];

    if (Platform.isIOS) {
      controller = new AudioController(CommonFormat.Int16, 44100, 1,
          true); //16000 -> 44100  //16 bit pcm => max.value = 2^16/2
      initAudio();
    }

    if (Platform.isAndroid) {

      stream = microphone(
          sampleRate: 44100,
          audioSource: AudioSource.MIC,
          channelConfig: ChannelConfig.CHANNEL_IN_MONO, //or stereo??? pls help
          audioFormat: AudioFormat
              .ENCODING_PCM_16BIT); //16 bit pcm => max.value = 2^16/2
      stream.asBroadcastStream();
    }
  }



  Future<void> initAudio() async {
    await controller.intialize();
  }




  Future<void> deInitAudio() async {
    await controller.stopAudioStream();
  }





  @override
  void dispose() {
    listener.cancel();
    controller.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  double calculate(List<int> finalSamples) {
    if (finalSamples.isNotEmpty) {
      // finalSamples.sort();

      if (finalSamples.reduce(max).abs() >= finalSamples.reduce(min)) {
        _result = finalSamples.reduce(max).abs().toDouble();
      } else {
        _result = finalSamples.reduce(min).toDouble();
      }

    }else _result = 0.0;

    print("laenge= ");
    print(finalSamples.length);
    print("dauer");
    print(finalSamples.length / 44100);

    _result = 20 * log(_result)*log10e;
    return _result;
  }

  void _startMeasurement() {
    if (!isRecording) {
      if (Platform.isAndroid) {

        if (listener == null) {
          listener = stream.listen((samples) {
            if(isRecording)appendCurrent(samples);
          },
          onError: (err){
            print("error in der Streamsubscription");
          },
          cancelOnError: false,
            onDone: () {
            print("Streamsubscription fertig??");

          },


          );

        } else if (listener.isPaused) {
          //wegen cancel fehler
          listener.resume();
        }
        startTime = DateTime.now();
      } else if (Platform.isIOS) {
        controller
            .startAudioStream()
            .listen((samples) => currentSamples = samples);
      }
      isRecording = true;
    } else if (isRecording) {
      if (Platform.isAndroid) {
        //listener.cancel(); // Fehler!!
        listener.pause();
        //listener = null;
        //listener.pause();
        //stream = null;

      } else if (Platform.isIOS) {
        deInitAudio();
      }
      isRecording = false;
      //currentSamples = [];
    }

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      if (isRecording) status = "running";
      if (!isRecording) status = "not running";
      _result = calculate(finalSamples);
      finalSamples = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              status,
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startMeasurement,
        tooltip: 'Start',
        child: Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
