

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/data.dart';

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
  final Data data;
  final Account account;

  SuccessLoadData({@required this.account, @required this.data});

  @override
  List<Object> get props {
    return [data, account];
  }

}

class FailedLoadData extends HomeState{}