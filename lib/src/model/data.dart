
import 'package:updateperutangan/src/model/account.dart';

class DataUser{

  Account account;
  int credit;
  int debt;


  DataUser({
    this.account,
    this.credit,
    this.debt
  });

  DataUser.fromJson(Map<String, dynamic> json) {

    if(json['account'] != null){
      this.account = Account.fromJson(json['account']);
    }
    this.credit = json['credit'];
    this.debt = json['debt'];
  }


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();

    data['account'] = this.account;
    data['credit'] = this.credit;
    data['debt'] = this.debt;

    return data;
  }

}