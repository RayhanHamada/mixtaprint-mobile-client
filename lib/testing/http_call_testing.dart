import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

final fun = CloudFunctions.instance;

class TestHttpCallPage extends StatefulWidget {
  @override
  _TestHttpCallPageState createState() => _TestHttpCallPageState();
}

class _TestHttpCallPageState extends State<TestHttpCallPage> {
  
  final HttpsCallable callable = fun.getHttpsCallable(functionName: 'prepUserStorageAndDB');


  Future<void> makeCall() async
  {
    final a = await callable.call({
      'nama' : 'hamada'
    }).then((result){
      print(result.data['success']);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: makeCall,
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
