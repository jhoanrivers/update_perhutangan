import 'package:shared_preferences/shared_preferences.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_event.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_state.dart';
import 'package:bloc/bloc.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  @override
  // TODO: implement initialState
  DetailState get initialState => InitialState();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key);

    if (event is ActionForRequest) {
      yield LoadingState();

      try{

        var response = await http.post(
          'https://dev-hutangku.herokuapp.com/confirm/request',
          headers: {HttpHeaders.authorizationHeader : 'Basic $value'},
          body: jsonEncode(<String, dynamic> {
            'loan_id' : event.loan_id,
            'status_loan' : event.status_loan
          })
        );
        if(response.statusCode == 200){
          yield SuccessState();
        } else{
          yield ErrorState();
        }

      } catch(_){
        yield ErrorState();
      }



    }
  }
}
