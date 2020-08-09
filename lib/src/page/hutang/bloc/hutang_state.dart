
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';
import 'package:updateperutangan/src/model/loan_hutang.dart';

abstract class HutangState extends Equatable{
  const HutangState();

  @override
  List<Object> get props {
    return [];
  }
}


class InitialState extends HutangState{}

class LoadingState extends HutangState{}

class LoadedState extends HutangState{
  final List<DataLoanHutang> listHutang;

  LoadedState({this.listHutang});

  @override
  List<Object> get props => [listHutang];
}

class ErrorState extends HutangState{}

class SuccessChangeItemViewed extends HutangState {
  final DataLoanHutang dataLoanHutang;

  SuccessChangeItemViewed({this.dataLoanHutang});

  @override
  List<Object> get props => [dataLoanHutang];

}

class FailedChangeItemViewed extends HutangState{}