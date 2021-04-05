


import 'package:updateperutangan/src/model/item_belanja.dart';

import 'account.dart';

class PurchaseItem {

  PurchaseItem({
    this.items,
    this.account,
  });

  List<ItemBelanja> items;
  List<Account> account;



  factory PurchaseItem.fromJson(Map<String, dynamic> json) => PurchaseItem(
    items: ItemBelanja.parseListDataLoanPiutang(json["items"]),
    account: Account.parseList(json["account"]),
  );
  
}