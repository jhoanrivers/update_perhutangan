import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/data_credit_hutang.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_bloc.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_event.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class DetailPage extends StatefulWidget {
  final DataCreditHutang dataHutang;

  DetailPage({this.dataHutang});

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
    date = widget.dataHutang.loan.createdat.substring(0,10);
    time = widget.dataHutang.loan.createdat.substring(12, 16);
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
                title: Text(
                  widget.dataHutang.loan.item,
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
                    color: widget.dataHutang.loan.status_loan == 'pending'
                        ? Colors.yellow
                        : widget.dataHutang.loan.status_loan == 'accepted'
                        ? Colors.orange
                        : widget.dataHutang.loan.status_loan =='paid'
                        ? Colors.green
                        : Colors.red,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Rp. ' + widget.dataHutang.loan.amount.toString(),
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
                                'Nama Pemberi Uang',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.dataHutang.lender_username +
                                    " " +
                                    "(${widget.dataHutang.lender_name})",
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
                                widget.dataHutang.loan.status_loan,
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
                                widget.dataHutang.loan.description.isEmpty
                                    ? '-'
                                    : widget.dataHutang.loan.description,
                                style: BaseStyle.ts14PrimaryName,
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
          widget.dataHutang.loan.status_loan == 'pending'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                  loan_id: widget.dataHutang.loan.id,
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

          widget.dataHutang.loan.status_loan == 'pending'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                  loan_id: widget.dataHutang.loan.id,
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
