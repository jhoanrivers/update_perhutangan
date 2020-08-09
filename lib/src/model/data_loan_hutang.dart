

import 'dart:convert';

import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/loan_hutang.dart';

class DataLoanHutang {
  LoanHutang loanHutang;
  Account account;


  DataLoanHutang(this.account, this.loanHutang);


  DataLoanHutang.fromJson(Map<String, dynamic> dataJson) {
    loanHutang = LoanHutang.fromJson(dataJson['request']);
    account = Account.fromJson(dataJson['account']);
  }

  static List<DataLoanHutang> parseListDataLoan(List<dynamic> jsonList) {
    List<DataLoanHutang> listDataLoanHutang = [];
    jsonList.forEach((element) {
      listDataLoanHutang.add(DataLoanHutang.fromJson(element));
    });
    return listDataLoanHutang;
  }


  Map<String, dynamic> toJson() =>
      {
        'request' : loanHutang,
        'account' : account
      };




}