

import 'dart:convert';

import 'package:updateperutangan/src/page/register/bloc/register_event.dart';
import 'package:updateperutangan/src/page/register/bloc/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/service/service_client.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  @override
  // TODO: implement initialState
  RegisterState get initialState => InitialRegister();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if(event is RegisterButtonPressed){
      yield LoadingRegister();

      try{
        final http.Response response = await  http.post(
             ServiceClient.baseUrl + "/register",
          body: jsonEncode(<String, String>{
            'username' : event.username,
            'name' : event.name,
            'password' : event.password,
            'ovo' : event.ovo,
            'gopay' :event.gopay,
            'gopay_name' : event.gopayName,
            'ovo_name' : event.ovoName,
            'fcm_token' : event.fcm_token
          })
        );

        print(response.body);
        if(response.statusCode == 200){
          yield SuccessRegister();
        } else{
          yield ErrorRegister();
        }
      }catch(_){
        yield ErrorRegister();
      }



    }
  }

}