

class ApiResponse{

  String data;
  String time;

  ApiResponse(this.data, this.time);

  ApiResponse.fromJson(Map<String, dynamic> dataJson){
    this.data = dataJson['data'];
    this.time = dataJson['time'];
  }

}