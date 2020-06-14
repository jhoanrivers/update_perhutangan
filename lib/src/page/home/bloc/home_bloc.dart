

import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data.dart';
import 'package:updateperutangan/src/page/home/bloc/home_event.dart';
import 'package:updateperutangan/src/page/home/bloc/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  @override
  // TODO: implement initialState
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if (event is FetchAllDataAndRecentlyTransaction){
      yield LoadingState();

      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.getString(key);

      try{

        final response = await  http.get(
          'https://dev-hutangku.herokuapp.com/account',
          headers: {HttpHeaders.authorizationHeader : 'Basic $value'}
        );

        if(response.statusCode == 200){
          Map<String, dynamic> dataJson = json.decode(response.body);
          Data data = Data.fromJson(dataJson);
          Account account = Account.fromJson(dataJson['data']['account']);

          yield SuccessLoadData(data: data, account: account);
        } else{
          FailedLoadData();
        }
      } catch(_){
        yield FailedLoadData();
      }

    }

  }

}