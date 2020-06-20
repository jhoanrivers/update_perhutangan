


import 'package:updateperutangan/src/model/loan_hutang.dart';

class DataCreditHutang {

  LoanHutang loan;
  String lender_name;
  String lender_username;


  DataCreditHutang(this.loan, this.lender_name, this.lender_username);

  DataCreditHutang.fromJson(Map<String, dynamic> dataJson) {

    if(dataJson['loan'] != null){
      this.loan = LoanHutang.fromJson(dataJson['loan']);
    }
    this.lender_name = dataJson['borrower_name'];
    this.lender_username = dataJson['borrower_username'];
  }


  static List<DataCreditHutang> parseList(List<dynamic> jsonList){
    List<DataCreditHutang> list = [];
    jsonList.forEach((element) {
      list.add(DataCreditHutang.fromJson(element));
    });
    return list;
  }


}