import 'package:User/screens/print_details.dart';
import 'package:User/widgets/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history.dart';
import '../const.dart';
import 'card_items.dart';
import 'package:User/screens/login.dart';
import 'package:User/services/auth_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAvailable = true;
  int currentIndex = 0;
  double statusBarHeight;

  bool _isNotifications = true;
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 30.0),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Constants.textPrimary,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Constants.textPrimary,
                ),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Constants.textPrimary,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Constants.textPrimary,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.print),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrintDetails(),
          ),
        ),
        backgroundColor: Color.fromRGBO(69, 127, 202, 1),
      ),
      backgroundColor: Colors.blue[50],
      body: IndexedStack(
        index: currentIndex,
        children: <Widget>[
          _buildDashboard(statusBarHeight, context),
          _buildProfile(context),
        ],
      ),
    );
  }

  Widget _buildDashboard(double statusBarHeight, BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: MyCustomClipper(clipType: ClipType.bottom),
          child: Container(
            color: Colors.blueAccent[100],
            height: Constants.headerHeight + statusBarHeight,
          ),
        ),
        Positioned(
          right: -45,
          top: -30,
          child: ClipOval(
            child: Container(
              color: Colors.black.withOpacity(0.05),
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.height * 0.33,
            ),
          ),
        ),

        // BODY
        Padding(
          padding: EdgeInsets.only(
            top: Constants.paddingSide,
            left: Constants.paddingSide,
            right: Constants.paddingSide,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Is Lalchand \nAvailable?",
                        style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                    CircleAvatar(
                      radius: 26.0,
                      backgroundColor: _isAvailable ? Colors.green : Colors.red,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                CardItems(
                  title: "Rates",
                  color: Constants.lightYellow,
                  subtitle: 'Black & White Page  -  ₹2\n\nColor Page  -  ₹10',
                  height: 150,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "RECENT PRINTS",
                  style: TextStyle(
                      color: Constants.textPrimary,
                      fontSize: 15,
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
                        title: "Question Papers",
                        value: "20",
                        unit: "pages",
                        color: Constants.lightYellow,
                        amount: 50,
                      ),
                      CardItems(
                        title: "OS Lab",
                        value: "30",
                        unit: "pages",
                        color: Constants.lightBlue,
                        amount: 100,
                      ),
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryPage())),
                          child: Text(
                            'View Full History',
                            style: TextStyle(
                              fontSize: 18,
                              color: Constants.textPrimary,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfile(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(
          top: statusBarHeight + MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.height * 0.03,
          right: MediaQuery.of(context).size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 36.0,
                color: Constants.textPrimary,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/hrithikRashan.jpg'),
                        radius: 60.0,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        'Tanuj Pandey',
                        style: TextStyle(
                          color: Constants.textPrimary,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        'tanuj.pandey18@st.niituniversity.in',
                        style: TextStyle(
                          color: Constants.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'PUSH NOTIFICATIONS',
                        style: TextStyle(
                            color: Constants.textPrimary,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Switch(
                        activeColor: Colors.blueAccent[100],
                        inactiveTrackColor: Colors.grey,
                        value: _isNotifications,
                        onChanged: (value) => setState(
                          () {
                            _isNotifications = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'NOTIFICATIONS',
                        style: TextStyle(
                            color: Constants.textPrimary,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Switch(
                        activeColor: Colors.blueAccent[100],
                        inactiveTrackColor: Colors.grey,
                        value: _isNotifications,
                        onChanged: (value) => setState(
                          () {
                            _isNotifications = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        _authService.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      title: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              color: Constants.textPrimary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
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
