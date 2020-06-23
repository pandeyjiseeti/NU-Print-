import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lalchandosfinal/Utils/const.dart';
import 'package:lalchandosfinal/Widget/card_items.dart';
import 'package:lalchandosfinal/Widget/card_main.dart';
import 'package:lalchandosfinal/Widget/card_section.dart';
import 'package:lalchandosfinal/Widget/custom_clipper.dart';

import '../cardMain1.dart';
import '../dataTables.dart';
import '../flutterCHartsCallingPage.dart';
import '../impContacts.dart';
import '../paymentCallingPage.dart';
import '../subscriptionCallingPage.dart';

class HomeScreen1 extends StatelessWidget {
  String msg = 'Hey! Lal Chand here';
  String base64Image = "";

  bool status3 = false;

  Future<bool> _onBackPressed() {
    return showDialog(
//        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure you want to exit"),
              actions: [
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, true),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(70)),
                        elevation: 10,
                        child: Image.asset(
                          'assets/lc.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Text(
                          "Nu Printing App",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Colors.blueAccent,
                  Colors.blue,
                  Colors.blueAccent.shade400
                ])),
              ),
              CustomListview(
                  Icons.person,
                  " Dashboard ",
                  () => {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FlutterChartsCallingPage()))
                      }),
              CustomListview(
                  Icons.contact_mail,
                  "Wallet",
                  () => {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaymentWalletUICallingPage()))
                      }),
              CustomListview(
                  Icons.wc,
                  "List Of Person",
                  () => {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => DataTableDemo()))
                      }),
              CustomListview(
                  Icons.subscriptions,
                  "Subscriptions",
                  () => {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SubscriptionMyApp()))
                      }),
              CustomListview(
                  Icons.room_service,
                  "Connect with student",
                  () => {
                        FlutterShareMe()
                            .shareToWhatsApp(base64Image: base64Image, msg: msg)
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (BuildContext) => ))
                      }),
//            CustomListview(
//                Icons.account_balance_wallet,
//                "Wallet",
//                () => {
//                      Navigator.of(context).push(new MaterialPageRoute(
//                          builder: (BuildContext context) => WalletApp()))
//                    }),

              CustomListview(
                  Icons.home,
                  "Helpful Contacts",
                  () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext) => HelpfulContacts()))
                      }),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.bottom),
              child: Container(
                color: Theme.of(context).accentColor,
                height: Constants.headerHeight + statusBarHeight,
              ),
            ),
            Positioned(
              right: -45,
              top: -30,
              child: ClipOval(
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  height: 220,
                  width: 220,
                ),
              ),
            ),

            // BODY
            Padding(
              padding: EdgeInsets.all(Constants.paddingSide),
              child: ListView(
                children: <Widget>[
                  // Header - Greetings and Avatar
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Are You Available,\nLal Chand",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                      CircleAvatar(
                          radius: 26.0,
                          backgroundImage: AssetImage('assets/lc.jpg')),
//                      FlutterSwitch(
//                        showOnOff: true,
//                        activeTextColor: Colors.black,
//                        inactiveTextColor: Colors.blue[50],
//                        value: status3,
//                        onToggle: (val) {
////                          setState(() {
////                            status3 = val;
////                          });
//                        },
//                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Colors.blue[50],
                        value: status3,
                        onToggle: (val) {
//                          setState(() {
//                            status3 = val;
//                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 50),

                  // Main Cards - Heartbeat and Blood Pressure
                  Container(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CardMain(
                          image: AssetImage('assets/3.png'),
                          title: "Todays Summary",
                          value: "128",
                          unit: "no. of prints",
                          color: Constants.lightGreen,
                        ),
                        CardMain1(
                            image: AssetImage('assets/4.png'),
                            title: "Jobs Left",
                            value: "6/128",
                            unit: "no. of prints",
                            color: Constants.lightYellow)
                      ],
                    ),
                  ),

                  // Section Cards - Daily Medication
                  SizedBox(height: 50),

                  Text(
                    "List Of Next Jobs",
                    style: TextStyle(
                      color: Constants.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                      height: 125,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          CardSection(
                            image: AssetImage('assets/2.png'),
                            title: "Yukta Sharma",
                            value: "2",
                            unit: "no. of prints",
                            time: "6-7AM",
                            isDone: false,
                          ),
                          CardSection(
                            image: AssetImage('assets/1.png'),
                            title: "Tanish Gupta",
                            value: "1",
                            unit: "no. of prints",
                            time: "8-9AM",
                            isDone: true,
                          )
                        ],
                      )),

                  SizedBox(height: 50),

                  // Scheduled Activities
                  Text(
                    "SCHEDULED ACTIVITIES",
                    style: TextStyle(
                        color: Constants.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 20),

                  Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        CardItems(
                          image: Image.asset(
                            'assets/complete.jpg',
                          ),
                          title: "Kawal ",
                          value: "120",
                          unit: "pages",
                          color: Constants.lightYellow,
                          progress: 30,
                        ),
                        CardItems(
                          image: Image.asset(
                            'assets/waiting.png',
                          ),
                          title: "Tanuj ",
                          value: "30",
                          unit: "mins",
                          color: Constants.lightBlue,
                          progress: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListview extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomListview(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blueAccent))),
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      text,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
