
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/belanja_item.dart';

class Purchase {

  Purchase({
    this.belanjaItem,
    this.account,
  });



  List<BelanjaItem> belanjaItem;
  List<Account> account;


  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    belanjaItem: BelanjaItem.parseListItem(json["purchase"]),
    account: Account.parseList(json["account"]),
  );


}