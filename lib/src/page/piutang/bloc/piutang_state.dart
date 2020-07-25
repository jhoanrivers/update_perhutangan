

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/loan_piutang.dart';

abstract class PiutangState extends Equatable {
  const PiutangState();

  @override
  List<Object> get props {
    return [];
  }
}



class InitialState extends PiutangState{}

class LoadingState extends PiutangState{}

class CreatePiutangLoadingState extends PiutangState{}

class SuccessFetchPiutang extends PiutangState{
  final List<LoanPiutang> dataCredit;

  SuccessFetchPiutang({
    @required this.dataCredit,
  });

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


class SuccessPiutangBackState extends PiutangState{
  final List<LoanPiutang> dataCredit;

  SuccessPiutangBackState({
    @required this.dataCredit,
  });

}
