

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/detail/detail_page.dart';
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
    homeBloc.add(FetchAllDataAndRecentlyTransaction());
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
                                        Text(state.account.name,
                                          style: BaseStyle.ts14PrimaryName,),
                                        SizedBox(height: 6,),
                                        Text('Ini gak tau isinya apa')
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
                                          state.data.debt != null
                                              ? state.data.debt.toString()
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
                                        state.data.credit != null
                                            ? state.data.credit.toString()
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


                    Container(
                      height: 80.0 * 4,
                      child: ListView.builder(
                        itemBuilder: (context, index){
                          return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                              },
                              child: Card(
                                  margin: EdgeInsets.fromLTRB(16,6,16,0),
                                  child: ListTile(
                                      leading: CachedNetworkImage(
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
                                      title: Text('Nama User'),
                                      subtitle: Text('16/Juni/2020'),

                                      trailing: Icon(Icons.call_made,
                                        color: Colors.green,)
                                  )

                              )
                          );

                        },
                        itemCount: 4,
                        controller: scrollController,
                      ),
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
