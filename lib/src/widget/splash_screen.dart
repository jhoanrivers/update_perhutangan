
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:updateperutangan/src/page/home/home_page.dart';
import 'package:updateperutangan/src/page/login/login_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isUserLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(100),
              child: Column(
                children: <Widget>[
                  Image.asset('assets/logo.png'),
                  Text('Perhutangan',
                  style: BaseStyle.ts18WhiteBold,)
                ],
              )
            )

          ],
        ),
      ),

    );
  }



  startSplashScreen() async{




    return Timer(Duration(seconds: 3),(){
      if(isUserLogin){
        //Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      } else{
        //Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()), (route)=> false);
      }
    });

  }
}
