import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mixtaprint_mobile_client/resources/auth.dart';
import 'package:mixtaprint_mobile_client/resources/current_user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mixtaprint_mobile_client/resources/db_firestore.dart';
import 'package:mixtaprint_mobile_client/resources/storage.dart';

import 'home_page.dart';
import 'login_page.dart';

// TODO : tidy up PrintPage code
class PrintPage extends StatefulWidget {

  static final routeName = '/PrintPage';

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {

  var _text = Text(
    CurrentUser.inAppUsername,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  static var _fileName = '';

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _pathWidget = Text(
    _fileName,
    style: TextStyle(
        fontSize: 18
    ),
  );

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

  void toHomePage()
  {
    setState(() {
      Navigator.popAndPushNamed(context, HomePage.routeName);
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

  void _openFileExplorer() async
  {
    await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'docx')
        .then((file) {
      setState(() {
        _fileName = file.path ?? '';

      });
    });
  }

  void _print() async
  {
    if (_fileName != null || _fileName != '') await Storage.uploadToStorage(File(_fileName));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInAppUsername();
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
                  color: Colors.black,
                ),
                title: Text(
                    'Home'
                ),
                onTap: toHomePage,
              ),
              ListTile(
                leading: Icon(
                  Icons.print,
                  color: Colors.blue,
                ),
                title: Text(
                    'Start Print'
                ),
                onTap: (){},
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _openFileExplorer,
                child: Text(
                  'Open File Explorer'
                ),
                color: Colors.yellow,
              ),
              _pathWidget,
              RaisedButton(
                onPressed: _print,
                child: Text(
                    'Print !'
                ),
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
