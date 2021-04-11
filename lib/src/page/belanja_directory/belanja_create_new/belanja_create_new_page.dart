


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja_create_new/bloc/create_belanja_bloc.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja_create_new/bloc/create_belanja_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja_create_new/bloc/create_belanja_state.dart';
import 'package:updateperutangan/src/page/piutang/search_user_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';
import 'package:updateperutangan/src/utils/constant.dart';
import 'package:updateperutangan/src/utils/globals.dart';

class BelanjaCreateNewPage extends StatefulWidget {
  @override
  _BelanjaCreateNewPageState createState() => _BelanjaCreateNewPageState();
}

class _BelanjaCreateNewPageState extends State<BelanjaCreateNewPage> {

  CreateBelanjaBloc createBelanjaBloc;

  TextEditingController titleTextController = new TextEditingController();
  Map<int, Account> mapResult = new Map();
  List<Account> listUser = new List();
  List<int> members = [];
  AutovalidateMode autoVal = AutovalidateMode.onUserInteraction;
  DateTime purchaseDate;



  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBelanjaBloc = BlocProvider.of<CreateBelanjaBloc>(context);

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }





  // void buildAppbar
  _buildAppbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          _onWillPopScope();
        },
        color: Colors.black54,
      ),
      actions: [
        FlatButton(
            onPressed: (){
              doSaveNewBelanja();
            },
            child: Text('Save',
              style: BaseStyle.ts14PrimaryLabelGreen
            )
        )
      ],
      elevation: 2,
      backgroundColor: Colors.white,
      title: Text(Constant.createNewBelanja, style: BaseStyle.ts16Black,),
      centerTitle: false,
    );
  }
  
  /*
  body
   */
  _buildBody(){
    return BlocListener<CreateBelanjaBloc, CreateBelanjaState>(
        listener: (context, state) {

          if(state is LoadingCreateBelanja) {
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
                        Text("Creating process"),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if(state is SuccessCreateBelanja) {
            Navigator.pop(context);
            Toast.show("Success Create Belanja", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            members.clear();
            Navigator.pop(context);
          }

        },
        child: BlocBuilder<CreateBelanjaBloc, CreateBelanjaState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Purchase Name*',
                            style: BaseStyle.ts14PrimaryName,),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: titleTextController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide()
                                )
                            ),
                            autovalidateMode: autoVal,
                            validator: (value){
                              if(titleTextController.text.isEmpty){
                                return 'Title cannot be empty';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    // tanggal belanja
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Purchase Date',
                            style: BaseStyle.ts14PrimaryName,),
                          SizedBox(
                            height: 12,
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FlatButton(
                              color: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)
                              ),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                                        //print('change $date');
                                      }, onConfirm: (date) {
                                        setState(() {
                                          purchaseDate = date;
                                        });
                                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text( purchaseDate == null
                                      ? "Select purchasing date"
                                      : DateFormat("dd-MMMM-yyyy").format(purchaseDate),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                          ),
                          purchaseDate == null
                              ? Container()
                              : Padding(
                                padding: const EdgeInsets.fromLTRB(0,6,0,6),
                                child: GestureDetector(
                            onTap: (){
                                setState(() {
                                  purchaseDate = null;
                                });
                            },
                            child: Text('Reset Date',
                              style: BaseStyle.ts12PrimaryLabel,),
                                ),
                              )
                        ],
                      ),
                    ),
                    Divider(),

                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('People Who Joined*',
                              style: BaseStyle.ts14PrimaryName,),
                            SizedBox(
                              height: 12,
                            ),
                            mapResult.length != null
                                ? ListView.builder(
                              shrinkWrap: true,
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
                            )
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
                                    print(mapResult);
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
                          ],
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            );
          },
        ),

    );
  }
  

  
  /*
  on close app
   */
  Future<bool> _onWillPopScope() async {
    Navigator.pop(context);
    return false;
  }



  // do save
  void doSaveNewBelanja() {

    if(!_formKey.currentState.validate() || mapResult.length == 0) {
      autoVal = AutovalidateMode.always;
    } else {
      if(mapResult != null && mapResult.length > 0) {
        for(int i = 0 ; i < mapResult.length ; i++) {
          members.add(mapResult.keys.elementAt(i));
        }
        members.add(accountId);
      }
      createBelanjaBloc.add(DoCreateBelanja(
          date: DateFormat("dd-MMMM-yyyy").format(purchaseDate),
          members: members,
          title: titleTextController.text
      ));

    }

  }



  
  


}
