


import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/belanja_item.dart';
import 'package:updateperutangan/src/model/purchase.dart';

abstract class BelanjaState extends Equatable {

  const BelanjaState();

  @override
  // TODO: implement props
  List<Object> get props => [];

}

class InitialBelanja extends BelanjaState{}

class LoadingBelanja extends BelanjaState{}

class SuccessFetchDataBelanja extends BelanjaState {
  Purchase purchase;

  SuccessFetchDataBelanja({this.purchase});
}

class ErrorFetchDataBelanja extends BelanjaState {}
