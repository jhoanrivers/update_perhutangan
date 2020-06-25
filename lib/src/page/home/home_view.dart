

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  HomeBloc homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetUserCurrentHutPiut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perhutangan',
            style: BaseStyle.ts18WhiteBold,),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: BlocListener<HomeBloc,HomeState>(
          listener: (context, state){
          },
          child: BlocBuilder<HomeBloc,HomeState>(
            builder: (context, state){
              if(state is LoadingState){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(state is FailedLoadData){
                return Center(
                  child: Text('Failed Load data'),
                );
              }

              if(state is SuccessLoadData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 30),
                                      child: Row(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            imageUrl: "https://i.pinimg.com/originals/bf/f4/4b/bff44b786d593a55c4033afe4eef7f84.jpg",
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: imageProvider
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(state.datauser.account.username,
                                          style: BaseStyle.ts14PrimaryName,),
                                        SizedBox(height: 6,),
                                        Text(state.datauser.account.name,
                                          style: BaseStyle.ts14PrimaryLabel,)
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text('Hutang'),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          state.datauser.debt != null
                                              ? state.datauser.debt.toString()
                                              : '0',
                                          style: BaseStyle.ts16RedBold,)
                                      ],
                                    ),
                                    VerticalDivider(),
                                    Column(
                                      children: <Widget>[
                                        Text('Piutang'),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          state.datauser.credit != null
                                              ? state.datauser.credit.toString()
                                              : '0',
                                          style: BaseStyle.ts16GreenBold,)
                                      ],
                                    ),
                                  ],
                                )

                              ],
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Text('Recently Transaction',
                        style: BaseStyle.ts14PrimaryName,),
                    ),

                    state.lasTransaction.length == 0
                        ? Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Text('No recently transaction',
                        style: BaseStyle.ts14PrimaryLabel,),
                    )
                        : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child:  ListView.builder(
                          itemBuilder: (context, index){
                            return GestureDetector(
                                onTap: (){},
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  margin:
                                  EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                                          color: state.lasTransaction[index].loan.status_loan ==
                                              'pending'
                                              ? Colors.yellow
                                              : state.lasTransaction[index].loan
                                              .status_loan ==
                                              'accepted'
                                              ? Colors.orange
                                              : state.lasTransaction[index].loan
                                              .status_loan ==
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
                                            state.lasTransaction[index].lender_username == state.datauser.account.username
                                                ? Icon(Icons.call_made,
                                            color: Colors.green,
                                            size: 30,)
                                                : Icon(Icons.call_received,
                                              color: Colors.red,
                                              size: 30,),
                                            Container(
                                              width: 160,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${state.lasTransaction[index].lender_username} ' +
                                                        "(${state.lasTransaction[index].lender_name})",
                                                    style: BaseStyle.ts14PrimaryBold,
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text(
                                                      state.lasTransaction[index].loan.item)
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
                                                    state.lasTransaction[index].loan
                                                        .createdat,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text(
                                                    state.lasTransaction[index].loan.amount
                                                        .toString(),
                                                    style: BaseStyle.ts16BlackBold,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            );

                          },
                          itemCount: state.lasTransaction.length,
                          controller: scrollController,
                        )

                    ),
                  ],
                );
              }


              return Center(
                child: CircularProgressIndicator(),
              );



            },
          ),
        )
    );

  }
}
