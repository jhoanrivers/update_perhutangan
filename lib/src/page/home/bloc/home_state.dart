

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data.dart';
import 'package:updateperutangan/src/model/data_credit_hutang.dart';

abstract class HomeState extends Equatable{
  const HomeState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialState extends HomeState{}

class LoadingState extends HomeState{}

class SuccessLoadData extends HomeState{
  
  final DataUser datauser;
  List<DataCreditHutang> lasTransaction;

  SuccessLoadData({ @required this.datauser,this.lasTransaction});

  @override
  List<Object> get props {
    return [datauser, lasTransaction];
  }

}

class FailedLoadData extends HomeState{}

