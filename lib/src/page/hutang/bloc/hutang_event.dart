

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/data_loan_hutang.dart';

abstract class HutangEvent extends Equatable{
  const HutangEvent();

  @override
  List<Object> get props {
    return [];
  }
}


class FetchAllHutang extends HutangEvent{}


class ChangeItemAlreadyViewed extends HutangEvent{
  final DataLoanHutang dataLoanHutang;

  ChangeItemAlreadyViewed({this.dataLoanHutang});

  @override
  List<Object> get props => [dataLoanHutang];
}