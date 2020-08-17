
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/page/home/home_page.dart';
import 'package:updateperutangan/src/page/login/login_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';
import 'package:updateperutangan/src/utils/constant.dart';
import 'package:updateperutangan/src/widget/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isUserLogin = false;
  String perhutangan = "Perhutangan";
  var value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
    startSplashScreen();
  }


  void getPrefs() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      value = prefs.getString(Constant.token);

      if(value =='' || value== null){
        isUserLogin = false;
      } else{
        isUserLogin = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(100),
              child: Column(
                children: <Widget>[
                  Image.asset('assets/newlogo.png'),
                  Text(perhutangan,
                  style: BaseStyle.ts16BlackBold,)
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBar()));
      } else{
        //Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()), (route)=> false);
      }
    });

  }

}
