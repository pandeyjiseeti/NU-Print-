import 'package:User/screens/home.dart';
import 'package:User/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Register extends StatelessWidget {
  @override
  String _name = '';

  String _email = '';

  String _password = '';

  AuthService _authService = AuthService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
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
                'Sign Up',
                style: TextStyle(fontSize: 46.0),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) {
                        if (val.length < 4 || val.length > 15 || val.isEmpty) {
                          return 'Name should be 4 to 15 characters long';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 24.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (val) {
                        _name = val;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 24.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (val) {
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(val)) {
                          return 'Incorrect Email';
                        }
                      },
                      onChanged: (val) {
                        _email = val;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.remove_red_eye),
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 24.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (val) {
                        if (val.length < 8 || val.isEmpty) {
                          return 'Password should be more than 8 characters';
                        }
                      },
                      onChanged: (val) {
                        _password = val;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 55.0, bottom: 30.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.14,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: RaisedButton(
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            if (await _authService.signUp(_email, _password) !=
                                null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            }
                          },
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
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                  minHeight:
                                      MediaQuery.of(context).size.width * 0.14),
                              alignment: Alignment.center,
                              child: Text(
                                "Sign Up",
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
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account ?   ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                              text: 'Sign In',
                              style: Theme.of(context).textTheme.subtitle1,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
