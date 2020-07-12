


import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/dashboard.dart';
import 'package:updateperutangan/src/model/data_credit_piutang.dart';
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

    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('token');
    List<DataCreditPiutang> listDataCredit;

    List<Account> listAccount = new List();


    if(event is CreatePiutang){
      yield CreatePiutangLoadingState();
      Map<String,dynamic> data = {
        'borrower' : event.id,
        'item' : event.item,
        'description' : event.description,
        'amount' : event.amount
      };


      try{
        http.Response response = await http.post(
          'https://dev-hutangku.herokuapp.com/new/request',
          body: json.encode(data),
          headers: {HttpHeaders.authorizationHeader: 'Basic $value'}
        );

        if(response.statusCode == 200){
          yield SuccessCreatePiutang();
        } else{
          yield ErrorCreatePiutang();
        }
      } catch(_){
        yield ErrorCreatePiutang();
      }
    }


    if(event is SearchUser){
      yield LoadingState();
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

    if(event is FetchAllPiutang){
      yield LoadingState();
      try{
        var response = await http.get(
          'https://dev-hutangku.herokuapp.com/all/credit',
          headers: {HttpHeaders.authorizationHeader : 'Basic $value'}
        );

        if(response.statusCode== 200){
         Map<String, dynamic> dataJson = json.decode(response.body);
         var checkData = dataJson['data'];
         if(checkData != null){
           listDataCredit = DataCreditPiutang.parseList(dataJson['data']);
         }
          else{
           listDataCredit = [];
         }

         yield SuccessFetchPiutang(
           dataCredit: listDataCredit
         );
        } else{
          yield ErrorFetchPiutang();
        }
      } catch(_){
        yield ErrorFetchPiutang();
      }


    }


  }


}