

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/data_loan_piutang.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_page.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_bloc.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_event.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_state.dart';
import 'package:updateperutangan/src/page/piutang/create_putang_form.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class PiutangView extends StatefulWidget {

  const PiutangView();

  @override
  _PiutangViewState createState() => _PiutangViewState();
}

class _PiutangViewState extends State<PiutangView> {

  PiutangBloc piutangBloc;
  GlobalKey<RefreshIndicatorState> _refreshIndicator = GlobalKey<RefreshIndicatorState>();
  bool anyUpdate = false;

  @override
  void initState() {
    super.initState();
    piutangBloc = BlocProvider.of<PiutangBloc>(context);
    piutangBloc.add(FetchAllPiutang());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Piutang',
        style: BaseStyle.ts16Black,),
        iconTheme: IconThemeData(
          color: Colors.black
        ),

      ),
      body: RefreshIndicator(
        key: _refreshIndicator,
        onRefresh: () async{
          piutangBloc.add(FetchAllPiutang());
        },
        child: BlocListener<PiutangBloc, PiutangState>(
          listener: (context, PiutangState state){
            if (state is SuccessCreatePiutang){
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Create Piutang Successfull',
                    style: BaseStyle.ts14White,),
                  backgroundColor: Colors.green,
                ),
              );

            }

            if(state is LoadingState){
              Center(
                child: Text('Loading'),
              );
            }

            if(state is SuccessChangeItemAlreadyViewed){
              doNavigateToDetailPiutang(state.dataLoanPiutang);
            }

          },

          child: BlocBuilder<PiutangBloc, PiutangState>(
            builder: (context, state){

              if(state is LoadingState){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is SuccessFetchPiutang){
                if(state.dataLoanPiutang.isEmpty){
                  return Center(
                    child: Text('No any credit'),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index){
                  return GestureDetector(
//                    onTap: () async{
//                      anyUpdate = await Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => DetailPiutangPage(dataCredit: state.dataCredit[index].loanPiutang, dataAccount: state.dataCredit[index].dataAccount,)));
//
//                      if(anyUpdate){
//                        setState(() {
//                          piutangBloc.add(FetchAllPiutang());
//                        });
//                      }
//                      },
                  
                  onTap: (){
                    if(state.dataLoanPiutang[index].loanPiutang.is_new == 't') {
                      piutangBloc.add(ChangeItemAlreadyViewed(state.dataLoanPiutang[index]));
                    } else{
                      doNavigateToDetailPiutang(state.dataLoanPiutang[index]);
                    }

                  },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                              color: state.dataLoanPiutang[index].loanPiutang.status_loan == 'pending'
                                  ? Colors.yellow
                                  : state.dataLoanPiutang[index].loanPiutang.status_loan =='accepted'
                                  ? Colors.orange
                                  : state.dataLoanPiutang[index].loanPiutang.status_loan == 'rejected'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
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
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text('${state.dataLoanPiutang[index].dataAccount.name}',
                                                style: BaseStyle.ts14PrimaryBold,),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              state.dataLoanPiutang[index].loanPiutang.is_new == 't'
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
                                          Text(state.dataLoanPiutang[index].loanPiutang.item)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(state.dataLoanPiutang[index].loanPiutang.created,
                                        overflow: TextOverflow.ellipsis,),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(state.dataLoanPiutang[index].loanPiutang.amount.toString(),
                                        style: BaseStyle.ts16BlackBold,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  );
                },
                  itemCount: state.dataLoanPiutang.length,
                );
              }

              if(state is ErrorFetchPiutang){
                return Center(
                  child: Text('zerror'),
                );

              }


              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),





      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          
          anyUpdate = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
              BlocProvider(
                create: (BuildContext context) {
                  return PiutangBloc();
                },
                child:  CreatePiutangForm(),
              ),)
          );

          if(anyUpdate) {
            piutangBloc.add(FetchAllPiutang());
            anyUpdate = false;
          }


        },
        child: Icon(Icons.add,
        color: Colors.white,),
        elevation: 4,
        tooltip: 'Add Piutang',
        backgroundColor: Colors.deepOrangeAccent,
      ),

    );
  }

  Future<void> doNavigateToDetailPiutang(DataLoanPiutang dataLoanPiutang) async {

    anyUpdate = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPiutangPage(dataLoanPiutang: dataLoanPiutang)));

    if(anyUpdate){
      setState(() {
        piutangBloc.add(FetchAllPiutang());
      });
    }
  }
}
