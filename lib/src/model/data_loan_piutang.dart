

import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/loan_hutang.dart';
import 'package:updateperutangan/src/model/loan_piutang.dart';

class DataLoanPiutang {
  LoanPiutang loanPiutang;
  Account dataAccount;

  DataLoanPiutang(this.loanPiutang, this.dataAccount);


  DataLoanPiutang.fromJson(Map<String, dynamic> dataJson) {
    loanPiutang = LoanPiutang.fromJson(dataJson['request']);
    dataAccount = Account.fromJson(dataJson['account']);
  }

  static List<DataLoanPiutang> parseListDataLoanPiutang (List<dynamic> dataJson) {
    List<DataLoanPiutang> newListLoanPiutang = [];
    dataJson.forEach((element) {
      newListLoanPiutang.add(DataLoanPiutang.fromJson(element));
    });
    return newListLoanPiutang;
  }



}