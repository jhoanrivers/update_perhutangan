import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/database/dbclient.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/dashboard.dart';
import 'package:updateperutangan/src/page/login/api_response.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_event.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/service/service_client.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  Account dataUser;

  @override
  // TODO: implement initialState
  ProfileState get initialState => InitialState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key);



    if (event is UserFetchData) {
      yield LoadingState();
      try {
        final response = await http.get(
            ServiceClient.baseUrl +'/my-account',
            headers: {HttpHeaders.authorizationHeader: 'Bearer $value'});

        if (response.statusCode == 200) {
          Map<String, dynamic> dataJson = json.decode(response.body);
          dataUser = Account.fromJson(dataJson['data']);
          yield SuccessFetchData(dataUser: dataUser);
        } else {
          yield FailedFetchData();
        }
      } catch (_) {
        yield FailedFetchData();
      }
    }

    if (event is UserLogoutEvent) {
      yield LoadingLogoutState();
      try {

        final response = await http.post(
          ServiceClient.baseUrl + '/logout',
          headers: {HttpHeaders.authorizationHeader: 'Bearer $value'}
        );
        if(response.statusCode == 200){
          prefs.setString(key, '');
          yield SuccessLogoutState();
        } else{
          yield FailedLogoutState();
        }
      } catch (_) {
        yield FailedLogoutState();
      }
    }


    if (event is EditProfileEvent) {
      yield LoadingEditData();


      Map<String, dynamic> body = {
        "password": event.dataAccount.password,
        "name": event.dataAccount.name,
        "ovo_name" : event.dataAccount.ovoName,
        "ovo": event.dataAccount.ovo,
        "gopay_name": event.dataAccount.gopayName,
        "gopay": event.dataAccount.gopay,
        "dana_name": event.dataAccount.danaName,
        "dana":event.dataAccount.dana,
        "fcm_token": event.dataAccount.fcmtoken
      };


      try {

        var response = await http.put(
          ServiceClient.baseUrl+"/user/update",
          body: jsonEncode(body),
          headers: {HttpHeaders.authorizationHeader : "Bearer $value"}
        );

        if (response.statusCode == 200) {
          yield LoginAgainAfterEditData();

          Map<String, dynamic> body = {
            "username" : event.dataAccount.username,
            "password" : event.dataAccount.password
          };


          var responseAgain = await http.post(
            ServiceClient.baseUrl+"/login",
            body: json.encode(body),
            headers: {
              'fcm_token' : event.dataAccount.fcmtoken
            }
          );

          print(responseAgain.body);

          var dataJson= json.decode(responseAgain.body);
          String dataToken = dataJson['data'];


          print("new Tokennya adalah :" + dataToken);
          prefs.setString(Constant.token, dataToken);

           yield SuccessEditProfile();

        } else {
          yield FailedEditProfile();
        }

      } catch(_){
        yield FailedEditProfile();
      }



    }





  }
}
