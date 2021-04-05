
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/purchase.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja/bloc/belanja_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja/bloc/belanja_state.dart';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/service/service_client.dart';

class BelanjaBloc extends Bloc<BelanjaEvent, BelanjaState> {

  @override
  BelanjaState get initialState => InitialBelanja();

  @override
  Stream<BelanjaState> mapEventToState(BelanjaEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    final key  = 'token';
    final value = prefs.get(key);

    if(event is GetListBelanja)  {
      yield LoadingBelanja();
      try {

        final response = await http.get(
          ServiceClient.baseUrl + '/purchase?offset=${event.start}&limit=${event.finish}',
          headers: {HttpHeaders.authorizationHeader: 'Bearer $value'}
        );

        if(response.statusCode == 200) {
          Map<String, dynamic> dataJson = json.decode(response.body);
          var currentData = dataJson['data'];
          Purchase purchase = Purchase.fromJson(currentData);
          yield SuccessFetchDataBelanja(purchase: purchase);
        } else {
          yield ErrorFetchDataBelanja();
        }
      } catch(_) {
        print(_);
        yield ErrorFetchDataBelanja();
      }



    }




  }


}