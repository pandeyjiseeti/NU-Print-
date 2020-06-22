import 'package:User/const.dart';
import 'package:User/screens/card_items.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Widget> _listCardItems = [
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
    CardItems(
      title: "OS Lab",
      value: "30",
      unit: "pages",
      color: Constants.lightBlue,
      amount: 100,
      height: 125,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blue[50],
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 15.0),
                child: Text(
                  'Order History',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: _listCardItems,
                ),
              )
            ]),
      ),
    );
  }
}
