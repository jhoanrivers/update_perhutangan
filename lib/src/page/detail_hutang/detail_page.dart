import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';
import 'package:updateperutangan/src/model/loan_hutang.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_bloc.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_event.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_state.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_bloc.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_event.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class DetailPage extends StatefulWidget {

  final DataLoanHutang dataLoanHutang;

  DetailPage({this.dataLoanHutang});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {



  DetailBloc detailBloc;
  HutangBloc hutangBloc;


  @override
  void initState() {
    super.initState();
    detailBloc = BlocProvider.of<DetailBloc>(context);
    hutangBloc = BlocProvider.of<HutangBloc>(context);
    BackButtonInterceptor.add(backInterceptor);
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    BackButtonInterceptor.remove(backInterceptor);
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
                      Text("Loading"),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if(state is SuccessState){
          Navigator.pop(context);
          widget.dataLoanHutang.loanHutang.status_loan = state.status;
        }

        if(state is ErrorState){
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: widget.dataLoanHutang.loanHutang.status_loan == 'pending'
              ? Colors.yellow
                  : widget.dataLoanHutang.loanHutang.status_loan == 'accepted'
              ? Colors.orange
                  : widget.dataLoanHutang.loanHutang.status_loan =='paid'
              ? Colors.green
                : Colors.red,
                elevation: 0,
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                  icon: Icon(Icons.keyboard_arrow_left),
                ),
                iconTheme: IconThemeData(color: Colors.black),
                title: Text("Detail Hutang",
                  style: BaseStyle.ts16Black,
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
                    color: widget.dataLoanHutang.loanHutang.status_loan == 'pending'
                        ? Colors.yellow
                        : widget.dataLoanHutang.loanHutang.status_loan == 'accepted'
                        ? Colors.orange
                        : widget.dataLoanHutang.loanHutang.status_loan =='paid'
                        ? Colors.green
                        : Colors.red,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Rp. ' + widget.dataLoanHutang.loanHutang.amount.toString(),
                      style: BaseStyle.ts18BlackBold,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
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
                              Text(widget.dataLoanHutang.loanHutang.item,
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
                              Text(widget.dataLoanHutang.account.name,
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
                                widget.dataLoanHutang.loanHutang.status_loan,
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
                                 widget.dataLoanHutang.loanHutang.created,
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
                                widget.dataLoanHutang.loanHutang.description.isEmpty
                                    ? '-'
                                    : widget.dataLoanHutang.loanHutang.description,
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
                                  Text(widget.dataLoanHutang.account.gopayName + " - " + widget.dataLoanHutang.account.gopay,
                                    style: BaseStyle.ts14PrimaryName,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.content_copy),
                                    color: Colors.grey,
                                    onPressed: (){
                                      Clipboard.setData(ClipboardData(text: widget.dataLoanHutang.account.gopay));
                                      Toast.show("Nomor Gopay telah disalin", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                    },
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
                                  Text(widget.dataLoanHutang.account.ovoName + " - "+ widget.dataLoanHutang.account.ovo,
                                    style: BaseStyle.ts14PrimaryName,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      Clipboard.setData(ClipboardData(text: widget.dataLoanHutang.account.ovo));
                                      Toast.show("Nomor Ovo telah disalin", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                    },
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
          widget.dataLoanHutang.loanHutang.status_loan == 'pending'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                  loan_id: widget.dataLoanHutang.loanHutang.id,
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

          widget.dataLoanHutang.loanHutang.status_loan == 'pending'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                  loan_id: widget.dataLoanHutang.loanHutang.id,
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

          widget.dataLoanHutang.loanHutang.status_loan == 'accepted'
              ? ListTile(
            onTap: (){},
            leading: Icon(Icons.monetization_on,
            color: Colors.black,),
            title: Text('Pay',
            style: BaseStyle.ts14GreyBlue,),
          )
              : Container()

        ],
      ),
    );



  }






  bool backInterceptor(bool stopDefaultButtonEvent) {
    Navigator.pop(context, true);
    return true;
  }
}
