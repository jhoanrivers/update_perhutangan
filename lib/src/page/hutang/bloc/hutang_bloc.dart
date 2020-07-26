
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';
import 'package:updateperutangan/src/model/loan_hutang.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_event.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;


class HutangBloc extends Bloc<HutangEvent, HutangState> {
  @override
  // TODO: implement initialState
  HutangState get initialState => InitialState();

  @override
  Stream<HutangState> mapEventToState(HutangEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('token');
    List<DataLoanHutang> listDataHutang;

    if(event is FetchAllHutang){
      yield LoadingState();

      try{
        var response = await http.get(
          'https://dev-hutangku.herokuapp.com/all/debt',
          headers: {HttpHeaders.authorizationHeader : 'Bearer $value'}
        );

        if(response.statusCode == 200){

          Map<String, dynamic> dataJson = json.decode(response.body);
          var checkData = dataJson['data'];
          if(checkData != null){
            listDataHutang = DataLoanHutang.parseListDataLoan(dataJson['data']);
          } else{
            listDataHutang = [];
          }
          yield LoadedState(listHutang: listDataHutang);

        } else{
          yield ErrorState();
        }
      } catch(_){
        yield ErrorState();
      }
    }

  }


}