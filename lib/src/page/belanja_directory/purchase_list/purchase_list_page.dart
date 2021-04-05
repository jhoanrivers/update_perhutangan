

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/add_purchase/add_purchase_form.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_bloc.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class PurchaseListPage extends StatefulWidget {

  final int id;

  const PurchaseListPage({Key key, this.id}) : super(key: key);

  @override
  _PurchaseListPageState createState() => _PurchaseListPageState();
}

class _PurchaseListPageState extends State<PurchaseListPage> {


  PurchaseListBloc purchaseListBloc;


  @override
  void initState() {
    super.initState();
    purchaseListBloc = BlocProvider.of<PurchaseListBloc>(context);
    purchaseListBloc.add(GetPurchaseList(id: widget.id));
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPopScope,
        child: Scaffold(
          appBar: _buildAppbar(),
          body: _buildBody(),
          floatingActionButton: _buildFloatActionButton(),
        )
    );
  }

  Future<bool> onWillPopScope() async{
    Navigator.pop(context);
    return false;
  }

  // build appbar
  _buildAppbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          onWillPopScope();
        },
        color: Colors.black54,
      ),
      elevation: 2,
      backgroundColor: Colors.white,
      title: Text(Constant.ListPurchase, style: BaseStyle.ts16Black,),
      centerTitle: false,
    );

  }

  // build body
  _buildBody() {
    return BlocListener<PurchaseListBloc, PurchaseListState>(
        listener: (context, state) {



        },
      child: BlocBuilder<PurchaseListBloc, PurchaseListState>(
        builder: (context, state) {

          if(state is PurchaseLoadingList) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PurchaseSuccessGetList){
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Purchased Item List',
                          style: BaseStyle.ts14PrimaryLabel,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        state.purchaseItem.items == null || state.purchaseItem.items.length == 0
                            ? Text('No item purhcased yet')
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  print("tarararam");
                                },
                                title: Text(toBeginningOfSentenceCase(state.purchaseItem.items[index].name)),
                                subtitle: Text("Added by "+getBuyerItem(state.purchaseItem.items[index].createdBy, state)),
                                trailing: Text(state.purchaseItem.items[index].price.toString()),
                              )
                            );
                          },
                          itemCount: state.purchaseItem.items.length,
                        )
                      ],
                    ),
                  ),
                ],
              )
            );
          }


          return Center(
            child: Text("Refresh Page"),
          );

        },
      ),
    );
  }


  // get user account by Id
  String getBuyerItem(int createdBy, PurchaseSuccessGetList state) {
    for(int i = 0; i< state.purchaseItem.account.length ; i++){
      if(createdBy == state.purchaseItem.account[i].id){
        return state.purchaseItem.account[i].name;
      }
    }
  }



  // build Float Action Button
  _buildFloatActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepOrangeAccent,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPurchaseForm(id: widget.id,)));
      },
      child: Icon(Icons.add),
    );

  }


}
