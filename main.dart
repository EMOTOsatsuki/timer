import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'ListPage.dart';

void main(){
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'alarm',
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      home: HomePage(),
    );
  }
}

//==============ホーム==================
var homePageKey = GlobalKey<_HomePageState>();

class HomePage extends StatefulWidget{
  @override
  HomePage({Key key}) :super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ListPage(
            key: listPageKey,
          )
        ],
      ),
    );
  }
}




//=====================================

