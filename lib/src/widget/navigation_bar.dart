


import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';
import 'package:updateperutangan/src/model/data_loan_piutang.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_page.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_page.dart';
import 'package:updateperutangan/src/page/home/home_page.dart';
import 'package:updateperutangan/src/page/hutang/hutang_page.dart';
import 'package:updateperutangan/src/page/hutang/hutang_view.dart';
import 'package:updateperutangan/src/page/notification/notification_page.dart';
import 'package:updateperutangan/src/page/piutang/piutang_page.dart';
import 'package:updateperutangan/src/page/piutang/piutang_view.dart';
import 'package:updateperutangan/src/page/profile/profile_page.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}


class _NavigationBarState extends State<NavigationBar> {


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var accountId;


  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: HomePage(),
    ),
    Center(
      child: HutangPage(),
    ),
    Center(
      child: PiutangPage(),
    ),
    Center(
      child: NotificationPage(),
    ),
    Center(
      child: ProfilePage(),
    )


  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_received),
            title: Text('Hutang')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made,),
            title: Text('Piutang')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
         _selectedIndex == 1
             ? Colors.red
             : _selectedIndex == 2
                ? Colors.green
                : Colors.deepOrangeAccent,
        selectedLabelStyle: TextStyle(
          color: _selectedIndex == 1
              ? Colors.red
              : _selectedIndex == 2
                ? Colors.green
                : Colors.grey,
        ),
        onTap: _onTapItem,
        unselectedItemColor: Colors.grey,


      ),
    );
  }

  void _onTapItem(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  void initState() {
    firebaseCloudMessaging();
    initLocalNotification();
    getSharedPreference();
  }

  // get Id account user

  void getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accountId = prefs.getInt(Constant.account_id);
    });
  }


  void firebaseCloudMessaging() {
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          if(Platform.isAndroid){
            showNotificationDefaultSound(message);
          } else{
            Map<String, dynamic> dataMessage = json.decode(message['body']);
            showNotificationDefaultSound(dataMessage);
          }
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
        });
  }

  initLocalNotification() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        requestSoundPermission: false,
        requestAlertPermission: false,
        requestBadgePermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }


  Future onSelectNotification(String payload) async {

    var decodePayload = json.decode(payload);
    var tempData = decodePayload['data']['body'];
    var afterPayload = json.decode(tempData);

    var idDataAccount = afterPayload['request']['borrower'];

    if(idDataAccount == accountId){
      DataLoanHutang dataLoanHutang = DataLoanHutang.fromJson(afterPayload);
      doNavigateToDetailHutang(context, dataLoanHutang);
    } else {
      DataLoanPiutang dataLoanPiutang = DataLoanPiutang.fromJson(afterPayload);
      doNavigateToDetailPiutang(context,dataLoanPiutang);
    }


    //DataLoanHutang tempDataLoanHutang = DataLoanHutang.fromJson(dataHutang);
    //doNavigateToDetailHutang(context,tempDataLoanHutang);

  }


  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
                },
              )
            ],
          ),
    );
  }

  Future showNotificationDefaultSound(Map<String, dynamic> message) async {


    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: json.encode(message),
    );
  }
}

  void doNavigateToDetailHutang(BuildContext context,DataLoanHutang dataHutang) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetailPage(
          dataLoanHutang: dataHutang,
        )
    ));
}

void doNavigateToDetailPiutang(BuildContext context, DataLoanPiutang dataLoanPiutang){
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => DetailPiutangPage(
        dataLoanPiutang: dataLoanPiutang,
      )
  ));
}

