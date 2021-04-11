


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


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


class DeleteItemFromList extends PurchaseListEvent{
  final int id;

  DeleteItemFromList({@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];

}