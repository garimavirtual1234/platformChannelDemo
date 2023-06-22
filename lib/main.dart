import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // String _responseFromNativeCode = 'Waiting for response...';
  String _batteryLevel = "Unknown battery level";

  // Step 1 -> Create platform channel
  static const platform = MethodChannel('flutter.native/helper');

  //step 2 -> Invoke method on platform channel
  // helloFromNativeCode() async {
  //   String response = "";
  //   try{
  //     final String result = await platform.invokeMethod('helloFromNativeCode');
  //     response = result;
  //   } on PlatformException catch (e){
  //     response = "Failed to Invoke: '${e.message}'";
  //   }
  //   setState(() {
  //     _responseFromNativeCode = response;
  //   });
  // }


  // in invoke we put the function name which is decleared in mainActivity
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try{
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel='Battery level at $result % .';
    } on PlatformException catch(e){
       batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context){
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
        //  helloFromNativeCode();
              _getBatteryLevel();
            }, child: const Text(
              'Get Battery Level')
            ),
            Text(_batteryLevel)
          ],
        ),
      ),
    );
  }


}
