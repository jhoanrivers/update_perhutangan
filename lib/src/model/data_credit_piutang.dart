


import 'package:updateperutangan/src/model/loan_piutang.dart';

class DataCreditPiutang {

  LoanPiutang loan;
  String borrower_name;
  String borrower_username;

  DataCreditPiutang(this.loan, this.borrower_name, this.borrower_username);

  DataCreditPiutang.fromJson(Map<String, dynamic> dataJson) {

    if(dataJson['loan'] != null){
      this.loan = LoanPiutang.fromJson(dataJson['loan']);
    }
    this.borrower_name = dataJson['borrower_name'];
    this.borrower_username = dataJson['borrower_username'];

  }
  

  static List<DataCreditPiutang> parseList(List<dynamic> jsonList){
    List<DataCreditPiutang> list = [];
    jsonList.forEach((element) {
      list.add(DataCreditPiutang.fromJson(element));
    });
    return list;
  }


}