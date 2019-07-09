import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/resources/current_user.dart';
import 'package:mixtaprint_mobile_client/resources/db_firestore.dart';
import 'package:mixtaprint_mobile_client/ui/print_page.dart';

import 'login_page.dart';

// TODO : tidy up HomePage code
class HomePage extends StatefulWidget {
  static final routeName = '/HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _text = Text(
    CurrentUser.inAppUsername,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onBackPressed() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Logout and exit to login page'),
            content: Text('Are you sure ?'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: _toLoginPageAndLogout,
                  ),
                  Container(
                    width: 30,
                  ),
                  RaisedButton(
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          );
        });
  }

  Future<void> _toLoginPageAndLogout() async {
    await Auth.logout();
    setState(() {
      Navigator.popAndPushNamed(context, LoginPage.routeName);
    });
  }

  Future<void> _getInAppUsername() async {
    await Auth.auth.currentUser().then((user) async {
      await FirestoreDB.dbFirestore
          .collection('users_client')
          .document('${user.uid}')
          .get()
          .then((snapshot) {
        setState(() {
          _text = Text(
            snapshot.data['inAppUsername'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInAppUsername();
  }

  void toPrintPage()
  {
    setState(() {
      Navigator.popAndPushNamed(context, PrintPage.routeName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 50,
                            ),
                            radius: 40,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: _text
                          ),
                          Chip(
                            label: Text(
                              'Premium',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            backgroundColor: Colors.orange,
                          )
                        ],
                      ),
                    ],
                  )
                ),
                padding: const EdgeInsets.only(right: 20),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                title: Text(
                  'Home'
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.print,
                  color: Colors.black,
                ),
                title: Text(
                    'Start Print'
                ),
                onTap: toPrintPage,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'HomePage',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
