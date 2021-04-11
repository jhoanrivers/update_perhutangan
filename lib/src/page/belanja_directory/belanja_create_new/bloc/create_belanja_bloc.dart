
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:updateperutangan/src/page/belanja_directory/belanja_create_new/bloc/create_belanja_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja_create_new/bloc/create_belanja_state.dart';
import 'package:updateperutangan/src/service/service_client.dart';

class CreateBelanjaBloc extends Bloc<CreateBelanjaEvent,CreateBelanjaState>{


  @override
  // TODO: implement initialState
  CreateBelanjaState get initialState => InitialCreateBelanja();

  @override
  Stream<CreateBelanjaState> mapEventToState(CreateBelanjaEvent event) async* {

    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('token');


    if (event is DoCreateBelanja) {
      yield LoadingCreateBelanja();
      var url = ServiceClient.baseUrl+"/purchase";
      Map<String, dynamic> body = {
        "title" : event.title,
        "date" : event.date,
        "member" : event.members
      };

      try {
        var response = await http.post(
            url,
            body: json.encode(body),
            headers: {HttpHeaders.authorizationHeader : 'Bearer $value'}
        );

        if (response.statusCode == 200) {
          yield SuccessCreateBelanja();
        } else {
          yield ErrorCreateBelanja();
        }
      } catch (error) {
        print(error);
        yield ErrorCreateBelanja();
      }

    }


  }

}