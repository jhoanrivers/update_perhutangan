
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/page/login/bloc/login_event.dart';
import 'package:updateperutangan/src/page/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{


  @override
  LoginState get initialState => InitialLogin();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginButtonPressed){
      yield LoadingLogin();
      try{
        final http.Response response = await http.post(
          'https://dev-hutangku.herokuapp.com/login',
          body: jsonEncode(<String, String>{
            'username' : event.username,
            'password' : event.password
          }),
          headers: {
            'fcm_token' : event.userToken
          }
        );
        print(response.body);
        if(response.statusCode == 200){
          Map<String, dynamic> tempData = json.decode(response.body);
          String dataToken = tempData['data'];
          final prefs = await SharedPreferences.getInstance();
          final key = 'token';
          final value = dataToken;
          prefs.setString(key, value);
          yield SuccessLogin();
        } else{
          yield ErrorLogin();
        }
      } catch(_){
        yield ErrorLogin();
      }

    }

  }

}