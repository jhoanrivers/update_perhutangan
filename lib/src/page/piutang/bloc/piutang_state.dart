

import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/account.dart';

abstract class PiutangState extends Equatable {
  const PiutangState();

  @override
  List<Object> get props {
    return [];
  }
}



class InitialState extends PiutangState{}

class LoadingState extends PiutangState{}

class SuccessFetchPiutang extends PiutangState{
  //List data piutang

}

class SuccessCreatePiutang extends PiutangState{}

class ErrorCreatePiutang extends PiutangState{}

class ErrorFetchPiutang extends PiutangState{}


class SuccessFetchUser extends PiutangState{
  final List<Account> listAccount;

  SuccessFetchUser({this.listAccount});

  @override
  List<Object> get props => [listAccount];
}

class ErrorFetchUser extends PiutangState{}
