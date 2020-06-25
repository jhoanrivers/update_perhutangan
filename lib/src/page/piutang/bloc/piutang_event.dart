

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/account.dart';

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
