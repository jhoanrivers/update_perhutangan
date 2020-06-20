

import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/data_credit_hutang.dart';

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
  final List<DataCreditHutang> listHutang;

  LoadedState({this.listHutang});

  @override
  List<Object> get props => [listHutang];
}

class ErrorState extends HutangState{}