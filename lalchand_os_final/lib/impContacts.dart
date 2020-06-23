import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpfulContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          image: AssetImage('assets/impc.PNG'),
        ),
      ),
    );
  }
}
