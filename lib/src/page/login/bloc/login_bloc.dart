
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/page/login/api_response.dart';
import 'package:updateperutangan/src/page/login/bloc/login_event.dart';
import 'package:updateperutangan/src/page/login/bloc/login_state.dart';
import 'package:updateperutangan/src/service/service_client.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{


  @override
  LoginState get initialState => InitialLogin();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginButtonPressed){
      yield LoadingLogin();
      try{

        print(ServiceClient.baseUrl +'/login');
        final response = await http.post(
           ServiceClient.baseUrl +'/login',
          body: jsonEncode(<String, String>{
            'username' : event.username,
            'password' : event.password
          }),
          headers: {
            'fcm_token' : event.userToken
          }
        );

        Map<String, dynamic> dataJson = json.decode(response.body);
        ApiResponse apiResponse = ApiResponse.fromJson(dataJson);

        if(apiResponse.data == Constant.userNameDoesntExist){
          yield ErrorLogin(
            message: Constant.wrongUsernameOrPassword
          );
        } else if(apiResponse.data == Constant.wrongPassword){
          yield ErrorLogin(
            message: Constant.wrongPassword
          );
        } else{
          Map<String, dynamic> tempData = json.decode(response.body);
          String dataToken = tempData['data'];
          final prefs = await SharedPreferences.getInstance();
          final key = 'token';
          final value = dataToken;
          prefs.setString(key, value);
          yield SuccessLogin();
        }
      } catch(_){
        yield ErrorLogin(
          message: Constant.loginError
        );
      }

    }

  }

}