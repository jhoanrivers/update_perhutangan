import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/last_transaction.dart';

class Dashboard {
  Account account;
  int credit;
  int debt;
  List<LastTransaction> lastTransaction;

  Dashboard({this.account, this.credit, this.debt});

  Dashboard.fromJson(Map<String, dynamic> json) {
    if (json['my_account'] != null) {
      this.account = Account.fromJson(json['my_account']);
    }
    this.credit = json['credit'];
    this.debt = json['debt'];
    if (json['last_transaction'] != null) {
      this.lastTransaction = LastTransaction.parseList(json['last_transaction']);
    }
  }
}
