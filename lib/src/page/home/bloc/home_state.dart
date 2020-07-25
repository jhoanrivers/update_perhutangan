import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/dashboard.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class SuccessLoadData extends HomeState {
  final Dashboard dashboard;

  SuccessLoadData({this.dashboard});

  @override
  List<Object> get props {
    return [dashboard];
  }
}

class FailedLoadData extends HomeState {}
