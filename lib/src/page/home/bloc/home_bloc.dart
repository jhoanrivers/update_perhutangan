import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/database/dbclient.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/dashboard.dart';
import 'package:updateperutangan/src/page/home/bloc/home_event.dart';
import 'package:updateperutangan/src/page/home/bloc/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/page/login/login_page.dart';
import 'package:updateperutangan/src/service/service_client.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key);

    if (event is GetUserCurrentHutPiut) {
      yield LoadingState();
      try {
        final response = await http.get(
            ServiceClient.baseUrl + '/dashboard',
            headers: {HttpHeaders.authorizationHeader: 'Bearer $value'});
        if (response.statusCode == 200) {
          Map<String, dynamic> dataJson = json.decode(response.body);
          Dashboard dashboard = Dashboard.fromJson(dataJson['data']);

          //save user to local database
          prefs.setInt(Constant.account_id, dashboard.account.id);

          //dbClient.insertUserToDatabase(dashboard.account.toMap());
          yield SuccessLoadData(dashboard: dashboard);
        } else if (response.statusCode == 401){
          yield GoToLoginPage();
        }
        else {
          yield FailedLoadData();
        }
      } catch (_) {
        yield FailedLoadData();
      }
    }
  }

}
