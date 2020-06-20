

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    piutangBloc = BlocProvider.of<PiutangBloc>(context);
    piutangBloc.add(FetchAllPiutang());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Piutang',
        style: BaseStyle.ts18WhiteBold,),
      ),
      body: BlocListener<PiutangBloc, PiutangState>(
        listener: (context, state){

        },
        child: BlocBuilder<PiutangBloc, PiutangState>(
          builder: (context, state){

            if(state is LoadingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is SuccessFetchPiutang){
              if(state.dataCredit.isEmpty){
                return Center(
                  child: Text('No any credit'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){},
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 10,
                          color: state.dataCredit[index].loan.status_loan == 'pending'
                              ? Colors.yellow
                              : state.dataCredit[index].loan.status_loan =='accepted'
                              ? Colors.orange
                              : state.dataCredit[index].loan.status_loan == 'rejected'
                              ? Colors.red
                              : Colors.green,

                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              Container(
                                width :160,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${state.dataCredit[index].borrower_username} ' +"(${state.dataCredit[index].borrower_name})",
                                    style: BaseStyle.ts14PrimaryBold,),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(state.dataCredit[index].loan.item)
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(state.dataCredit[index].loan.createdat,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(state.dataCredit[index].loan.amount.toString(),
                                    style: BaseStyle.ts16BlackBold,)
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
                itemCount: state.dataCredit.length,
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





      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              BlocProvider(
                create: (BuildContext context) {
                  return PiutangBloc();
                },
                child:  CreatePiutangForm(),
              ),)
          );
        },
        child: Icon(Icons.add,
        color: Colors.white,),
        elevation: 4,
        tooltip: 'Add Piutang',
        backgroundColor: Colors.deepOrangeAccent,
      ),

    );
  }
}
