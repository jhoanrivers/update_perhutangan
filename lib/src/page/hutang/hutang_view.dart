import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_page.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_bloc.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_event.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class HutangView extends StatefulWidget {
  @override
  _HutangViewState createState() => _HutangViewState();
}

class _HutangViewState extends State<HutangView> {
  HutangBloc hutangBloc;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool hutangUpdated = false;

  @override
  void initState() {
    super.initState();

    hutangBloc = BlocProvider.of<HutangBloc>(context);
    hutangBloc.add(FetchAllHutang());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          'Hutang',
          style: BaseStyle.ts16Black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: (){},
        //     icon: Icon(Icons.search),
        //   ),
        //   IconButton(
        //     onPressed: (){
        //     },
        //     icon: Icon(Icons.chat),
        //   )
        // ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          hutangBloc.add(FetchAllHutang());
        },
        child: BlocListener<HutangBloc, HutangState>(
          listener: (context, state) {


            if(state is SuccessChangeItemViewed){
              doNavigateToHutangDetail(state.dataLoanHutang);
            }


          },
          child: BlocBuilder<HutangBloc, HutangState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }


              if (state is LoadedState) {
                if (state.listHutang.length == 0) {
                  return Center(
                    child: Text('No Hutang'),
                  );
                }



                return ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                          if(state.listHutang[index].loanHutang.is_new == 't'){
                            hutangBloc.add(ChangeItemAlreadyViewed(dataLoanHutang: state.listHutang[index]));
                          } else{
                            doNavigateToHutangDetail(state.listHutang[index]);
                          }

                        },
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
                                  color: state.listHutang[index].loanHutang.status_loan ==
                                      'pending'
                                      ? Colors.yellow
                                      : state.listHutang[index].loanHutang
                                      .status_loan ==
                                      'accepted'
                                      ? Colors.orange
                                      : state.listHutang[index].loanHutang
                                      .status_loan ==
                                      'rejected'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            imageUrl:
                                            "https://i.pinimg.com/originals/bf/f4/4b/bff44b786d593a55c4033afe4eef7f84.jpg",
                                            imageBuilder: (context, imageProvider) =>
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: imageProvider),
                                                  ),
                                                ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '${state.listHutang[index].account.name} ',
                                                      style: BaseStyle.ts14PrimaryBold,
                                                    ),
                                                    state.listHutang[index].loanHutang.is_new == 't'
                                                        ? Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(90),
                                                          color: Colors.green
                                                      ),
                                                      padding: EdgeInsets.all(4),
                                                      child: Text('New',
                                                        style: BaseStyle.ts11White,),
                                                    )
                                                        : Container()
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                    state.listHutang[index].loanHutang.item)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              state.listHutang[index]
                                                  .loanHutang.created,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              state.listHutang[index].loanHutang.amount
                                                  .toString(),
                                              style: BaseStyle.ts16BlackBold,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  },
                  itemCount: state.listHutang.length,
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  void helpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.fromLTRB(16,20,16,20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('Warna Pada item',
            style: BaseStyle.ts16BlackBold,),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              Icon(Icons.brightness_1,
              color: Colors.yellow,),
              SizedBox(
                width: 12
              ),
              Container(
                width: 260,
                child: Text('Item dengan flag kuning menandakan bahwa peminjam menunggu untuk melakukan transaksi',)
              )
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              Icon(Icons.brightness_1,
                color: Colors.orange,),
              SizedBox(
                  width: 12
              ),
              Container(
                  width: 260,
                  child: Text('Item dengan flag orange menandakan bahwa anda telah setuju berhutang terhadap si pemeberi',)
              )
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              Icon(Icons.brightness_1,
                color: Colors.green,),
              SizedBox(
                  width: 12
              ),
              Container(
                  width: 260,
                  child: Text('Item dengan flag hijau menandakan bahwa anda telah lunas',)
              )
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              Icon(Icons.brightness_1,
                color: Colors.red,),
              SizedBox(
                  width: 12
              ),
              Container(
                  width: 260,
                  child: Text('Item dengan flag merah menandakan bahwa anda menolak telah berhutang terhadap pihak pertama',)
              )
            ],
          ),


        ],
      ),
    );


  }

  Future<void> doNavigateToHutangDetail(DataLoanHutang dataLoanHutang) async {
    hutangUpdated = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
              dataLoanHutang: dataLoanHutang,
            )));
    if (hutangUpdated) {
      hutangBloc.add(FetchAllHutang());
      hutangUpdated = false;
    }

  }
}
