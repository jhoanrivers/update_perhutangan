import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/dashboard.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_event.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  // TODO: implement initialState
  ProfileState get initialState => InitialState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UserFetchData) {
      yield LoadingState();

      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.getString(key) ?? '';

      try {
        final response = await http.get(
            'https://dev-hutangku.herokuapp.com/account',
            headers: {HttpHeaders.authorizationHeader: 'Basic $value'});
        print(response.body);
        if (response.statusCode == 200) {
          Map<String, dynamic> dataJson = json.decode(response.body);
          Account dataUser = Account.fromJson(dataJson['data']);
          yield SuccessFetchData(dataUser: dataUser);
        } else {
          yield FailedFetchData();
        }
      } catch (_) {
        yield FailedFetchData();
      }
    }
    if (state is UserLogoutEvent) {
      yield LoadingState();
      try {
        final prefs = await SharedPreferences.getInstance();
        final key = 'token';
        prefs.setString(key, '');
        yield SuccessLogoutState();
      } catch (_) {
        yield FailedLogoutState();
      }
    }
  }
}
