

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/purchase_item.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/bloc/purchase_list_state.dart';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/service/service_client.dart';


class PurchaseListBloc extends Bloc<PurchaseListEvent, PurchaseListState> {

  PurchaseItem purchaseItem;


  @override
  PurchaseListState get initialState => PurchaseInitialList();

  @override
  Stream<PurchaseListState> mapEventToState(PurchaseListEvent event) async* {

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key);

    var baseUrl = ServiceClient.baseUrl;

    if (event is GetPurchaseList) {

      yield PurchaseLoadingList();
      try {

        var response = await http.get(
          "$baseUrl/purchase/item?purchase_id=${event.id}",
          headers: {HttpHeaders.authorizationHeader : 'Bearer $value'}
        );

        if(response.statusCode == 200) {
          Map<String, dynamic> dataJson = json.decode(response.body);
          var checkData = dataJson['data'];
          purchaseItem = PurchaseItem.fromJson(checkData);
          yield PurchaseSuccessGetList(purchaseItem: purchaseItem);

        } else {
          yield PurchaseFailedGetList();
        }

      } catch(error) {
        print(error);
        yield PurchaseFailedGetList();
      }


    }
    
    
    if (event is DeleteItemFromList){
      yield PurchaseLoadingList();

      try {

        var response = await http.delete(
            baseUrl+"/purchase/item?purchase_item_id=${event.id}",
            headers: {HttpHeaders.authorizationHeader : "Bearer $value"}
        );

        if(response.statusCode == 200) {
          for(int i=0 ; i< purchaseItem.items.length;i++){
            purchaseItem.items.removeWhere((element) => purchaseItem.items[i].id == element.id);
          }
          yield PurchaseSuccessGetList(purchaseItem: purchaseItem);
        } else {
          yield PurchaseFailedDeleteItem();
        }

      } catch (_) {
        yield PurchaseFailedDeleteItem();

      }

      
    }
    
    


  }




}