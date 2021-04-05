

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
          PurchaseItem purchaseItem = PurchaseItem.fromJson(checkData);
          yield PurchaseSuccessGetList(purchaseItem: purchaseItem);

        } else {
          yield PurchaseFailedGetList();
        }

      } catch(error) {
        print(error);
        yield PurchaseFailedGetList();
      }


    }


  }




}