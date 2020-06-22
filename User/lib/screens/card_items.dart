import 'package:User/widgets/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

class CardItems extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Color color;
  final int amount;
  final double height;
  final String subtitle;

  CardItems(
      {Key key,
      @required this.title,
      this.value,
      this.unit,
      this.subtitle,
      @required this.color,
      this.amount,
      this.height = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: height,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.halfCircle),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: color.withOpacity(0.1),
                ),
                height: 100,
                width: 100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Icon and Hearbeat
                SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '$title',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Constants.textPrimary),
                          ),
                          value == null || unit == null
                              ? Container()
                              : Text(
                                  '$value $unit',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Constants.textPrimary),
                                ),
                        ],
                      ),
                      SizedBox(height: 15),
                      subtitle == null
                          ? Container()
                          : Text('$subtitle',
                              style: TextStyle(
                                  fontSize: 15, color: Constants.textPrimary),),
                      amount == null
                          ? Container()
                          : Text(
                              '₹ $amount',
                              style: TextStyle(
                                  fontSize: 15, color: Constants.textPrimary),
                            ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
