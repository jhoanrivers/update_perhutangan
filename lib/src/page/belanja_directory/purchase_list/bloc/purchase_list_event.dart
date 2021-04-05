


import 'package:equatable/equatable.dart';

abstract class PurchaseListEvent extends Equatable {


  @override
  List<Object> get props => [];

}


class GetPurchaseList extends PurchaseListEvent {
  final int id;

  GetPurchaseList({this.id});
  @override
  List<Object> get props => [id];
}