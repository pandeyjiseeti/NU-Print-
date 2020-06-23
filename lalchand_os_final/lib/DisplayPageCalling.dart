import 'package:flutter/material.dart';
import 'package:lalchandosfinal/screens/home_screen.dart';

import 'Utils/const.dart';

class DisplayPageCalling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: Constants.lighTheme(context),
      debugShowCheckedModeBanner: false,
      home: HomeScreen1(),
    );
  }
}
