
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/data_credit_piutang.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_bloc/detail_bloc.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_bloc/detail_event.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_bloc/detail_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class DetailPiutangPage extends StatefulWidget {

  final DataCreditPiutang dataCredit;

  const DetailPiutangPage({Key key, this.dataCredit}) : super(key: key);

  @override
  _DetailPiutangPageState createState() => _DetailPiutangPageState();
}

class _DetailPiutangPageState extends State<DetailPiutangPage> {



  DetailPiutangBloc detailBloc;
  String date;
  String time;

  @override
  void initState() {
    super.initState();
    detailBloc = BlocProvider.of<DetailPiutangBloc>(context);
    date = widget.dataCredit.loan.createdat.substring(0,10);
    time = widget.dataCredit.loan.createdat.substring(12, 16);
  }




  @override
  Widget build(BuildContext context) {

    return BlocListener<DetailPiutangBloc, DetailState>(
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
              content: Text('Piutang paid is failed'),
              backgroundColor: Colors.red,
            ),
          );
          Future.delayed(Duration(milliseconds: 500), (){
            Navigator.pop(context, true);
          });
        }
      },
      child: BlocBuilder<DetailPiutangBloc, DetailState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.deepOrangeAccent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  'Detail Piutang',
                  style: BaseStyle.ts16WhiteBold,
                ),
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context, false);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios
                  ),
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
                    color: widget.dataCredit.loan.status_loan == 'pending'
                        ? Colors.yellow
                        : widget.dataCredit.loan.status_loan == 'accepted'
                        ? Colors.orange
                        : widget.dataCredit.loan.status_loan =='paid'
                        ? Colors.green
                        : Colors.red,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Rp. ' + widget.dataCredit.loan.amount.toString(),
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
                                'Peminjam',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.dataCredit.borrower_username +
                                    " " +
                                    "(${widget.dataCredit.borrower_name})",
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
                                'Item',
                                style: BaseStyle.ts12PrimaryLabel,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.dataCredit.loan.item,
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
                                widget.dataCredit.loan.status_loan,
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
                                widget.dataCredit.loan.description.isEmpty
                                    ? '-'
                                    : widget.dataCredit.loan.description,
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
          widget.dataCredit.loan.status_loan != 'paid'
              ? ListTile(
            onTap: (){
              detailBloc.add(ActionForRequest(
                status_loan: 'paid',
                loan_id: widget.dataCredit.loan.id
              ));
            },
            leading: Icon(Icons.play_circle_filled,
            color: Colors.black,),
            title: Text(
                "Paid",
                style: BaseStyle.ts14GreyBlue
            ),)
              : Container(),

        ],
      ),
    );



  }





}
