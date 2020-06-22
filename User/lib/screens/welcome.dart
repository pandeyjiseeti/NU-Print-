import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Text('Welcome to App',
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.w500)),
                  SizedBox(height: 10.0),
                  Text(
                    'Explore Us',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            'assets/images/login.jpg',
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.14,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: RaisedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(69, 127, 202, 1),
                              Color.fromRGBO(97, 144, 232, 0.6)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Log In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.14,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: FlatButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
