import 'package:User/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  final Map<String, dynamic> _printDetails;
  Payment(this._printDetails);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Razorpay _razorpay;
  int total;
  int bwPageAmount;
  int colorPageAmount;
  int noOfCopies;
  int noOfBWPages;
  int noOfColorPages;
  bool isTwoSide;
  List<String> attachmentURL;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    noOfCopies = widget._printDetails['No_of_Copies'];
    isTwoSide = widget._printDetails['Page_Side'];
    noOfColorPages = widget._printDetails['No_of_Color_Pages'];
    noOfBWPages = widget._printDetails['No_of_BW_Pages'];
    attachmentURL = widget._printDetails['attachment_URL'];
    _billCalculator();
    super.initState();
  }

  _billCalculator() {
    if (isTwoSide) {
      bwPageAmount = ((noOfBWPages * noOfCopies) / 2).ceil();
      colorPageAmount = ((noOfColorPages * noOfCopies) / 2).ceil();
    } else {
      bwPageAmount = noOfBWPages * noOfCopies;
      colorPageAmount = noOfColorPages * noOfCopies;
    }
    total = 2 * bwPageAmount + 10 * colorPageAmount;
  }

  _openCheckout() async {
    var options = {
      'key': 'rzp_test_1k52YHKiM6s9mf',
      'amount': total * 100, //in the smallest currency sub-unit.
      'name': 'LalChand Payment',
      'description': 'Test Payments',
      'prefill': {'contact': '', 'email': ''},
      'external': ['paytm']
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'SUCCESS : ' + response.paymentId);
    Navigator.pop(
      context,
    );
    MailOptions _mailOptions = MailOptions(
        recipients: [
          'ttanuj09@gmail.com',
          'tanish.gupta18@st.niituniversity.in'
        ],
        subject: 'Order From Tanuj Pandey',
        body:
            'Order : \n1. Black & White : $noOfBWPages\n2. Color : $noOfColorPages\n3. Copies : $noOfCopies',
        attachments: attachmentURL);
    try {
      FlutterMailer.send(_mailOptions);
    } catch (e) {
      Fluttertoast.showToast(msg: 'MAIL ERROR : ' + e.toString());
    }
  }

  _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg:
            'ERROR : ' + response.code.toString() + '  -  ' + response.message);
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'EXTERNAL WALLET : ' + response.walletName);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blueAccent[100],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 15.0),
              child: Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                elevation: 5.0,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Black & White', //  X ${_printDetails['No_of_BW'].toString()}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Constants.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Qty: $noOfBWPages',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Constants.textPrimary,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Text(
                                '₹ ${noOfBWPages * 2}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Constants.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Color', //  X ${_printDetails['No_of_BW'].toString()}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Constants.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Qty: $noOfColorPages',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Constants.textPrimary,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Text(
                                '₹ ${noOfColorPages * 10}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Constants.textPrimary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 15.0),
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Total', //  X ${_printDetails['No_of_BW'].toString()}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Constants.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Copies: $noOfCopies',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Constants.textPrimary,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Text(
                                '₹ $total',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Constants.textPrimary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 55.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.14,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    onPressed: () async =>
                        await _openCheckout(), //Navigator.pushReplacement(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) => Payment(),
                    // ),
                    // ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(69, 127, 202, 1),
                              Color.fromRGBO(97, 144, 232, 1)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight:
                                MediaQuery.of(context).size.width * 0.14),
                        alignment: Alignment.center,
                        child: Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
