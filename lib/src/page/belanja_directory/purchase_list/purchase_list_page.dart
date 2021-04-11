

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:updateperutangan/src/model/item_belanja.dart';
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
  bool isEdit = false;


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
      actions: [
        FlatButton(
            onPressed: (){
              setState(() {
                isEdit = !isEdit;
              });
            },
            child: isEdit
            ? Text(Constant.cancel, style: BaseStyle.ts14PrimaryLabel,)
            : Text(Constant.edit, style: BaseStyle.ts14OrangeLabel,)
        )
      ],
    );

  }

  // build body
  _buildBody() {
    return BlocListener<PurchaseListBloc, PurchaseListState>(
        listener: (context, state) {

          if(state is PurchaseLoadingDeleteList){
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
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(toBeginningOfSentenceCase(state.purchaseItem.items[index].name),
                                            style: BaseStyle.ts14PrimaryName,
                                          ),
                                          SizedBox(height: 6,),
                                          Text(state.purchaseItem.items[index].price.toString(),
                                            style: BaseStyle.ts14PrimaryLabelGreen,),
                                          SizedBox(height: 6,),
                                          Text("Added by "+getBuyerItem(state.purchaseItem.items[index].createdBy, state),
                                            style: BaseStyle.ts12GreyLabel,),
                                        ],
                                      ),
                                    ),
                                    isEdit
                                        ? IconButton(
                                        icon: Icon(Icons.clear,
                                        color: Colors.black54,),
                                        onPressed: (){
                                          doShowDialogDelete(state.purchaseItem.items[index]);
                                        }
                                    )
                                        : Container()

                                  ],
                                ),
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


  Future<void> doShowDialogDelete(ItemBelanja item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${item.name}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete ${item.name}'),
                Text('Price is ${item.price}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
              style: BaseStyle.ts12GreyLabel,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Sure'),
              onPressed: () {
                purchaseListBloc.add(DeleteItemFromList(id: item.id));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
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
