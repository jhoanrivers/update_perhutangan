import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_page.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_page.dart';
import 'package:updateperutangan/src/page/home/bloc/home_bloc.dart';
import 'package:updateperutangan/src/page/home/bloc/home_event.dart';
import 'package:updateperutangan/src/page/home/bloc/home_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var scrollController = ScrollController();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  HomeBloc homeBloc;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetUserCurrentHutPiut());
    firebaseCloudMessaging();
    initLocalNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {


          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FailedLoadData) {
                return Center(
                  child: Text('Failed Load data'),
                );
              }
              if (state is SuccessLoadData) {
                return ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 150,
                                width: double.infinity,
                              ),
                              Container(
                                height: 210,
                                width: double.infinity,
                              )

                            ],
                          ),
                        ),
                        Container(
                          height: 240,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius
                                  .circular(10),
                                  bottomRight: Radius.circular(10)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF2193b0),
                                    Color(0xFF6dd5ed)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              )
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Text('Update Perutangan',
                                      style: BaseStyle.ts16WhiteBold,),
                                    Stack(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.chat,
                                          color: Colors.white,),
                                          onPressed: () {
                                            print('notif');
                                          },
                                        ),
                                        Positioned(
                                          top: 4,
                                          left: 4,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(90),
                                                color: Colors.pink
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 6, top: 2, bottom: 2),
                                            child: Text('1',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              "https://i.pinimg.com/originals/bf/f4/4b/bff44b786d593a55c4033afe4eef7f84.jpg",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: imageProvider),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                state.dashboard.account
                                                    .username,
                                                style: BaseStyle
                                                    .ts14PrimaryName,
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                state.dashboard.account.name,
                                                style: BaseStyle
                                                    .ts14PrimaryLabel,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text('Hutang',
                                                    style: BaseStyle.ts16Red,),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Icon(
                                                    Icons.call_received,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    state.dashboard.debt != null
                                                        ? state.dashboard.debt
                                                        .toString()
                                                        : '0',
                                                    style: BaseStyle
                                                        .ts16BlackBold,
                                                  )
                                                ],
                                              ),
                                              VerticalDivider(),
                                              Column(
                                                children: <Widget>[
                                                  Text('Piutang',
                                                    style: BaseStyle
                                                        .ts16Green,),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Icon(
                                                    Icons.call_made,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    state.dashboard.credit !=
                                                        null
                                                        ? state.dashboard.credit
                                                        .toString()
                                                        : '0',
                                                    style: BaseStyle
                                                        .ts16BlackBold,
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Text(
                        'Recently Transaction',
                        style: BaseStyle.ts16Black,
                      ),
                    ),
                    state.dashboard.lastTransaction.length == 0
                        ? Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Text(
                        'No recently transaction',
                        style: BaseStyle.ts14PrimaryLabel,
                      ),
                    )
                        : SizedBox(
                        height: 90.0 * state.dashboard.lastTransaction.length,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(6)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 80,
                                          width: 8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                bottomLeft:
                                                Radius.circular(6)),
                                            color: state.dashboard.lastTransaction[index]
                                                .statusLoan == 'pending'
                                                ? Colors.yellow
                                                : state
                                                .dashboard
                                                .lastTransaction[
                                            index]
                                                .statusLoan ==
                                                'accepted'
                                                ? Colors.orange
                                                : state
                                                .dashboard
                                                .lastTransaction[
                                            index]
                                                .statusLoan ==
                                                'rejected'
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              state.dashboard
                                                  .lastTransaction[index]
                                                  .lender ==
                                                  state.dashboard.account.id
                                                  ? Icon(
                                                Icons.call_made,
                                                color: Colors.green,
                                                size: 30,
                                              )
                                                  : Icon(
                                                Icons.call_received,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                              Container(
                                                width: 160,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(
                                                      state.dashboard
                                                          .lastTransaction[index]
                                                          .lenderUsername !=
                                                          null
                                                          ? '${state.dashboard
                                                          .lastTransaction[index]
                                                          .lenderUsername} ' +
                                                          "(${state.dashboard
                                                              .lastTransaction[index]
                                                              .lenderName})"

                                                          : '${state.dashboard
                                                          .lastTransaction[index]
                                                          .borrowerUsername} ' +
                                                          "(${state.dashboard
                                                              .lastTransaction[index]
                                                              .borrowerName})"
                                                      ,
                                                      style: BaseStyle
                                                          .ts14PrimaryBold,
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(state
                                                        .dashboard
                                                        .lastTransaction[
                                                    index]
                                                        .item)
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                      state
                                                          .dashboard
                                                          .lastTransaction[
                                                      index]
                                                          .created,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      state
                                                          .dashboard
                                                          .lastTransaction[
                                                      index]
                                                          .amount
                                                          .toString(),
                                                      style: BaseStyle
                                                          .ts16BlackBold,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            itemCount: state.dashboard.lastTransaction.length,
                            controller: scrollController,
                          ),
                        )),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }

  void firebaseCloudMessaging() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async{
        print('on message $message');
        showNotification(message);
      },
      onResume:  (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch:  (Map<String, dynamic> message) async {
        print('on launch $message');
      });

  }

  void initLocalNotification() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

  }


  Future selectNotification(String payload) async {

    var dataDecode = json.decode(payload);
    var tempLoanHutang = json.decode(dataDecode['data']['body']);
    DataLoanHutang dataLoanHutang = DataLoanHutang.fromJson(tempLoanHutang);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => DetailPage(
        dataLoanHutang: dataLoanHutang
      )
    ));
  }

  void showNotification(Map<String, dynamic> message) async{

    String dataToEncode = json.encode(message);
    var tempDataHutang = json.decode(message['data']['body']);

    DataLoanHutang dataLoanHutang = DataLoanHutang.fromJson(tempDataHutang);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, dataLoanHutang.account.name, 'Menambahkan hutang ${dataLoanHutang.loanHutang.amount}', platformChannelSpecifics,
        payload: dataToEncode);
  }


  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
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








}
