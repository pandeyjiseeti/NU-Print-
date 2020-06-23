import 'package:flutter/material.dart';

import 'chartsPage.dart';

class FlutterChartsCallingPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animated Charts App',
      theme: ThemeData(
        primaryColor: Color(0xffff6101),
      ),
      home: FlutterCharts(),
    );
  }
}
