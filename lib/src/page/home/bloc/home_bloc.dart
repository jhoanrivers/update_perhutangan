import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data.dart';
import 'package:updateperutangan/src/model/data_credit_hutang.dart';
import 'package:updateperutangan/src/page/home/bloc/home_event.dart';
import 'package:updateperutangan/src/page/home/bloc/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key);
    print(value);
    DataUser dataAccount;
    List<DataCreditHutang> listTransaction;

    if (event is GetUserCurrentHutPiut) {
      yield LoadingState();
      try {
        final response = await http.get(
            'https://dev-hutangku.herokuapp.com/account',
            headers: {HttpHeaders.authorizationHeader: 'Basic $value'});

        if (response.statusCode == 200) {
          Map<String, dynamic> dataJson = json.decode(response.body);
          dataAccount = DataUser.fromJson(dataJson['data']);
        }
        print(response.body);

        var responseTransaction = await http.get(
            'https://dev-hutangku.herokuapp.com/last/request',
            headers: {HttpHeaders.authorizationHeader : 'Basic $value'}
        );

        if(responseTransaction.statusCode ==200){
          Map<String, dynamic> dataJson = json.decode(responseTransaction.body);
          var checkData = dataJson['data'];
          if(checkData != null){
            listTransaction = DataCreditHutang.parseList(dataJson['data']);
          }
          else listTransaction = [];
        }
        yield SuccessLoadData(
            datauser: dataAccount,
            lasTransaction: listTransaction
        );
      } catch (_) {
        yield FailedLoadData();
      }
    }

  }
}
