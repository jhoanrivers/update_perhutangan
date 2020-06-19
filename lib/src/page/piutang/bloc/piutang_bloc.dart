


import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_event.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;


class PiutangBloc extends Bloc<PiutangEvent,PiutangState>{
  @override
  // TODO: implement initialState
  PiutangState get initialState => InitialState();



  @override
  Stream<PiutangState> mapEventToState(PiutangEvent event) async*{
    List<Account> listAccount = new List();

    if(event is FetchDataPiutang){

    }

    if(event is CreatePiutang){

    }

    if(event is SearchUser){
      yield LoadingState();
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString('token');
      try{
        var response = await http.get(
          'https://dev-hutangku.herokuapp.com/all/account',
          headers: {HttpHeaders.authorizationHeader: 'Basic $value'}
        );
        if(response.statusCode == 200){
          var dataJson = json.decode(response.body);

          var data = dataJson['data'];

          for(int i = 0; i< data.length;i++){
            Account acc = Account.fromJson(data[i]);
            listAccount.add(acc);
          }
          yield SuccessFetchUser(listAccount: listAccount);
        } else{
          yield ErrorFetchUser();
        }
      }catch(_){
        yield ErrorFetchUser();
      }

    }

  }


}