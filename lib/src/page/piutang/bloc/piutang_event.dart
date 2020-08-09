

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data_loan_piutang.dart';
import 'package:updateperutangan/src/model/loan_piutang.dart';

abstract class PiutangEvent extends Equatable{
  const PiutangEvent();

  @override
  List<Object> get props {
    return [];
  }
}


class CreatePiutang extends PiutangEvent{
  List<int> id;
  String item;
  String description;
  int amount;

  CreatePiutang({
    @required this.id,
    @required this.item,
    this.description,
    @required this.amount
  });

  @override
  List<Object> get props {
    return [
      id,
      item,
      description,
      amount
    ];
  }


}

class SearchUser extends PiutangEvent{}


class PiutangBackAfterSuccess extends PiutangEvent{}

class FetchAllPiutang extends PiutangEvent{}

class ChangeItemAlreadyViewed extends PiutangEvent{
  final DataLoanPiutang dataLoanPiutang;

  ChangeItemAlreadyViewed(this.dataLoanPiutang);

  @override
  List<Object> get props => [dataLoanPiutang];

}

