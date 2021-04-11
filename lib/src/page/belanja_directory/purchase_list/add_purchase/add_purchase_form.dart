
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/add_purchase/bloc/add_purchase_bloc.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/add_purchase/bloc/add_purchase_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/add_purchase/bloc/add_purchase_state.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_bloc.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_event.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class AddPurchaseForm extends StatefulWidget {

  final int id;

  const AddPurchaseForm({@required this.id});

  @override
  _AddPurchaseFormState createState() => _AddPurchaseFormState();
}

class _AddPurchaseFormState extends State<AddPurchaseForm> {


  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  AddPurchaseBloc addPurchaseBloc;
  PurchaseListBloc purchaseListBloc;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPurchaseBloc = BlocProvider.of<AddPurchaseBloc>(context);
    purchaseListBloc = BlocProvider.of<PurchaseListBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillpopScope,
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }


  _buildAppbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,
        color: Colors.black54,),
        onPressed: (){
          _onWillpopScope();
        },
      ),
      elevation: 2,
      backgroundColor: Colors.white,
      title: Text(Constant.addPurchaseItem, style: BaseStyle.ts16Black,),
      actions: [
        FlatButton(
            onPressed: (){
              _doSavePurchaseItem();
            },
            child: Text("Add Item")
        )
      ],
    );

  }


  _buildBody() {
    return BlocListener<AddPurchaseBloc, AddPurchaseState>(

        listener: (context, state){

          if (state is AddPurchaseLoading) {
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
                        Text("Adding item"),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is AddPurchaseSuccess) {
            Navigator.pop(context);
            purchaseListBloc.add(GetPurchaseList(id: widget.id));
            Navigator.pop(context);
          }

          },

      child: BlocBuilder<AddPurchaseBloc, AddPurchaseState>(
        builder: (context, state) {

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Name',
                          style: BaseStyle.ts14PrimaryName,),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide()
                            ),
                          ),
                          validator: (value) {
                            if(value.isEmpty){
                              return "Please insert item name";
                            }
                            return null;
                          },
                          maxLines: 1,
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
                        Text('Price',
                          style: BaseStyle.ts14PrimaryName,),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide()
                            ),
                          ),
                          validator: (value) {
                            if(value.isEmpty){
                              return "Please insert price item";
                            }
                            return null;
                          },
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),


                ],
              ),
            ),
          );

        },
      )


    );

  }





  Future<bool> _onWillpopScope() async{
    Navigator.pop(context);
    return false;
  }


  // do save purchase item
  void _doSavePurchaseItem() {
    if(!_formKey.currentState.validate()){
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    } else {
      addPurchaseBloc.add(AddPurchaseItem(id: widget.id, name: nameController.text, price: int.parse(priceController.text)));
    }


  }




}
