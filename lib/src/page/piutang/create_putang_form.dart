

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_bloc.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_event.dart';
import 'package:updateperutangan/src/page/piutang/search_user_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class CreatePiutangForm extends StatefulWidget {
  @override
  _CreatePiutangFormState createState() => _CreatePiutangFormState();
}

class _CreatePiutangFormState extends State<CreatePiutangForm> {

  PiutangBloc piutangBloc;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Map<int, Account> mapResult = new Map();
  List<Account> listUser = new List();

  var itemController = TextEditingController();
  var descriptionController = TextEditingController();
  var amountController = TextEditingController();
  bool autoVal = false;
  bool _validateResult = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    piutangBloc = BlocProvider.of<PiutangBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Create New Piutang',
        style: BaseStyle.ts18WhiteBold,),
      ),
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Yang Bersangkutan*',
                          style: BaseStyle.ts14PrimaryName,),
                        SizedBox(
                          height: 12,
                        ),
                        mapResult.length != null
                            ? Container(
                            height: 60.0 * mapResult.length,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: mapResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(mapResult.values.elementAt(index).name ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            mapResult.remove(mapResult.keys.elementAt(index));
                                          });
                                        },
                                        icon: Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ))
                            : Container(),

                        GestureDetector(
                          onTap: () async {
                           listUser = await Navigator.push(context,
                               MaterialPageRoute(builder: (context) => SearchUserPage()));

                           if(listUser != null){
                             for (var key in listUser){
                               setState(() {
                                 mapResult.putIfAbsent(key.id, () => key);
                               });
                             }
                           }
                          },
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.add,
                                  color: Colors.blue,),
                                Text('Tambahkan Orang',
                                  style: BaseStyle.ts12BlueBold,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        _validateResult
                            ? Text('Please add at least 1 user',
                        style:TextStyle(
                          color: Colors.red
                        ),)
                            : Container()
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Item*',
                          style: BaseStyle.ts14PrimaryName,),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: itemController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide()
                              )
                          ),
                          autovalidate: autoVal,
                          validator: (value){
                            if(itemController.text.isEmpty){
                              return 'Item cannot be empty';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Description',
                          style: BaseStyle.ts14PrimaryName,),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide()
                            ),

                          ),
                          maxLines: 5,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Amount*',
                          style: BaseStyle.ts14PrimaryName,),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: amountController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide()
                              ),
                              prefixText: 'Rp. ',
                              prefixStyle: BaseStyle.ts14PrimaryName
                          ),
                          keyboardType: TextInputType.number,
                          autovalidate: autoVal,
                          validator: (value){
                            if(itemController.text.isEmpty){
                              return 'Item cannot be empty';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          padding: EdgeInsets.all(14),
                          onPressed: onButtonSavedPressed,
                          child: Text('Tambahkan Piutang',
                          style: BaseStyle.ts14White,),
                        ),
                      )
                  )

                ],
              ),

            ),
          ],
        )
        
    );
  }

  void onButtonSavedPressed() {
    if(!_formKey.currentState.validate() || mapResult.length ==0){
      autoVal = true;
      setState(() {
        _validateResult = true;
      });
    } else{
      piutangBloc.add(
        CreatePiu
    }

  }
}
