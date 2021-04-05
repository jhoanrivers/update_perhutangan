

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/add_purchase/bloc/add_purchase_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/purchase_list/add_purchase/bloc/add_purchase_state.dart';
import 'package:updateperutangan/src/service/service_client.dart';

class AddPurchaseBloc extends Bloc<AddPurchaseEvent, AddPurchaseState> {
  @override
  // TODO: implement initialState
  AddPurchaseState get initialState => AddPurchaseInitial();

  @override
  Stream<AddPurchaseState> mapEventToState(AddPurchaseEvent event) async* {


    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key);


    if(event is AddPurchaseItem){
      yield AddPurchaseLoading();

      Map<String, dynamic> body = {
        "purchase_id": event.id,
        "price" : event.price,
        "name" : event.name
      };

      var url = ServiceClient.baseUrl+"/purchase/item";

      try{
        var response = await http.post(
          url,
          headers: {HttpHeaders.authorizationHeader : "Bearer $value"},
          body: json.encode(body)
        );
        print(response.body);
        if(response.statusCode == 200) {
          yield AddPurchaseSuccess();
        } else {
          yield AddPurchaseFailed();
        }

      } catch(_) {
        print(_);
        yield AddPurchaseFailed();
      }

    }
  }

}