

import 'package:updateperutangan/src/model/data.dart';

class APIResponse{

  Data data;
  String time;

  APIResponse({
    this.data,
    this.time
  });


  APIResponse.fromJson(Map<String, dynamic> json){
    this.data = json['data'];
    this.time = json['time'];

  }

}