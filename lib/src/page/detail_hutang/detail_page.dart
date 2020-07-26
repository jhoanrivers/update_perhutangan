import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/loan_hutang.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_bloc.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_event.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class DetailPage extends StatefulWidget {
  final LoanHutang dataHutang;
  final Account dataAccount;

  DetailPage({this.dataHutang, this.dataAccount});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {



  DetailBloc detailBloc;
  String date;
  String time;

  @override
  void initState() {
    super.initState();
    detailBloc = BlocProvider.of<DetailBloc>(context);
    date = widget.dataHutang.created.substring(0,10);
    time = widget.dataHutang.created.substring(12, 16);
  }




  @override
  Widget build(BuildContext context) {

    return BlocListener<DetailBloc, DetailState>(
      listener: (context, state) {
        if(state is LoadingState){
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20,),
                      Text("Loading Progress"),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if(state is SuccessState){
          Navigator.pop(context);
          Navigator.pop(context, true);
        }

        if(state is ErrorState){
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('You just rejected piutang confirmation'),
              backgroundColor: Colors.red,
            ),
          );
          Future.delayed(Duration(milliseconds: 500), (){
            Navigator.pop(context);
          });
        }
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.deepOrangeAccent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                title: Text("Detail Hutang",
                  style: BaseStyle.ts16WhiteBold,
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: (){
                      _showDialog(context,state);
                    },
                    icon: Icon(Icons.more_vert),
                  )
                ],
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    color: widget.dataHutang.status_loan == 'pending'
                        ? Colors.yellow
                        : widget.dataHutang.status_loan == 'accepted'
                        ? Colors.orange
                        : widget.dataHutang.status_loan =='paid'
                        ? Colors.green
                        : Colors.red,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Rp. ' + widget.dataHutang.amount.toString(),
                      style: BaseStyle.ts18BlackBold,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Item',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(widget.dataHutang.item,
                                style: BaseStyle.ts14PrimaryName,
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Pemberi',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(widget.dataAccount.name,
                                style: BaseStyle.ts14PrimaryName,
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Status',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.dataHutang.status_loan,
                                style: BaseStyle.ts14PrimaryName,
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Tanggal Peminjaman',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                date + " " + time,
                                style: BaseStyle.ts14PrimaryName,
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Detail Hutang',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.dataHutang.description.isEmpty
                                    ? '-'
                                    : widget.dataHutang.description,
                                style: BaseStyle.ts14PrimaryName,
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Gopay',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(widget.dataAccount.gopayName + " - " + widget.dataAccount.gopay,
                                    style: BaseStyle.ts14PrimaryName,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.content_copy),
                                    color: Colors.grey,
                                    onPressed: (){},
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'OVO',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(widget.dataAccount.ovoName + " - "+ widget.dataAccount.ovo,
                                    style: BaseStyle.ts14PrimaryName,
                                  ),
                                  IconButton(
                                    onPressed: (){},
                                    color: Colors.grey,
                                    icon: Icon(Icons.content_copy),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider()

                      ],
                    ),
                  )
                ],
              )
          );
        },
      ),
    );
  }

  void _showDialog(BuildContext context, DetailState state) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: <Widget>[
          widget.dataHutang.status_loan == 'pending'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                  loan_id: widget.dataHutang.id,
                  status_loan: 'accepted'
              ));
            },
            leading: Icon(Icons.play_circle_filled,
            color: Colors.black,),
            title: Text(
                "Accept",
                style: BaseStyle.ts14GreyBlue
            ),)
              : Container(),

          widget.dataHutang.status_loan == 'pending'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                  loan_id: widget.dataHutang.id,
                  status_loan: 'rejected'
              ));
            },
            leading: Icon(Icons.cancel,
            color: Colors.black,),
            title: Text(
                "Reject",
                style: BaseStyle.ts14GreyBlue
            ),)
              : Container(),

        ],
      ),
    );



  }





}
