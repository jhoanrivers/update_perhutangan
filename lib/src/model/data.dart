
import 'package:updateperutangan/src/model/account.dart';

class Data{

  Account account;
  int credit;
  int debt;


  Data({
    this.account,
    this.credit,
    this.debt
  });

  Data.fromJson(Map<String, dynamic> json) {
    this.account = json['account'];
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