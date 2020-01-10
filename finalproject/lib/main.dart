import 'package:flutter/material.dart';
import 'package:unique_identifier/unique_identifier.dart';

void main() => runApp(SelectorGamesApp());

class SelectorGamesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinalProject',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

 String deviceID = 'Unknown';
  
 @override
 void initState() {
   super.initState();
   initUniqueIdentifierState();
 }

 Future<void> initUniqueIdentifierState() async {
   String _deviceID;
    _deviceID = await UniqueIdentifier.serial;
   setState(() {
     deviceID = _deviceID;
   });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Main Page'),
       ),
       body: Center(
         child: Text('ID: $deviceID\n'),
       ),
     );
 }

}
