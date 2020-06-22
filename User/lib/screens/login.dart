import 'package:User/screens/signup.dart';
import 'package:User/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatelessWidget {
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
                'Login',
                style: TextStyle(fontSize: 46.0),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        _email = val;
                      },
                      validator: (val) {
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(val)) {
                          return 'Incorrect Email';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 24.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    TextFormField(
                      onChanged: (val) {
                        _password = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Password should not be empty';
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.remove_red_eye),
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 24.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 55.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.14,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: RaisedButton(
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            if (await _authService.signIn(_email, _password) !=
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
                    RichText(
                      text: TextSpan(
                        text: 'Dont have an account ?   ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.subtitle1,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
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
