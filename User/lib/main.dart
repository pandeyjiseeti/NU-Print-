import 'package:User/screens/welcome.dart';
import 'package:User/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isUserLoggedIn(_isLoggedIn),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ? Home() : Welcome();
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<bool> isUserLoggedIn(bool _isLoggedIn) async {
    _isLoggedIn = await _authService.isUserLogged();
    print(_isLoggedIn);
    return _isLoggedIn;
  }
}
