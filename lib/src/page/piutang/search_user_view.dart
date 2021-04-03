

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_bloc.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_event.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_state.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_event.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class SearchUserView extends StatefulWidget {
  @override
  _SearchUserViewState createState() => _SearchUserViewState();
}

class _SearchUserViewState extends State<SearchUserView> {


  PiutangBloc piutangBloc;
  var searchUserController = TextEditingController();
  List<Account> resultList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    piutangBloc = BlocProvider.of<PiutangBloc>(context);
    piutangBloc.add(SearchUser());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Select User',
        style: BaseStyle.ts16WhiteBold,),
        actions: <Widget>[
          FlatButton(
            child: Text('Select',
            style: BaseStyle.ts14WhiteBold,),
            onPressed: (){
              Navigator.pop(context,resultList);
              print(resultList.length);
            },
          )
        ],
      ),
      body: BlocListener<PiutangBloc, PiutangState>(
        listener: (context, state){
          
        },

        child: BlocBuilder<PiutangBloc, PiutangState>(
          builder: (BuildContext context, state) {
            if(state is SuccessFetchUser){
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        controller: searchUserController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide()
                            ),
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Search for name or username'
                        ),
                      ),
                    ),
                    state.listAccount.length == 0
                        ? Container(
                      height: 60,
                      child: Text('User is empty'),
                    )
                        : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              if (state.listAccount.any((item) => !item.isSelected || item.isSelected)) {
                                setState(() {
                                  state.listAccount[index].isSelected = !state.listAccount[index].isSelected;
                                });
                                if (state.listAccount[index].isSelected) {
                                  resultList.add(state.listAccount[index]);
                                } else {
                                  resultList.remove(state.listAccount[index]);
                                }
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                color: state.listAccount[index].isSelected
                                    ? Colors.black12
                                    : Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(16, 4, 10, 4),
                                      child: state.listAccount[index].isSelected
                                          ? Icon(
                                        Icons.check_box,
                                        color: Colors.blue,
                                      )
                                          : Icon(Icons.check_box_outline_blank,
                                          color: Colors.black54),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(16, 10, 10, 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            state.listAccount[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            state.listAccount[index].username,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          );


                          },
                        itemCount: state.listAccount.length == 0
                            ? state.listAccount.length +1
                            : state.listAccount.length,
                        shrinkWrap: true,

                      ),
                    )


                  ],
                ),
              );
            }


            if(state is ErrorFetchUser){
              return Center(
                child: Text('Error'),
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
