


import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/purchase_item.dart';

abstract class PurchaseListState extends Equatable {
  @override
  List<Object> get props => [];

}


class PurchaseInitialList extends PurchaseListState{}

class PurchaseLoadingList extends PurchaseListState{}

class PurchaseSuccessGetList extends PurchaseListState{
  final PurchaseItem purchaseItem;

  PurchaseSuccessGetList({this.purchaseItem});


  @override
  List<Object> get props => [purchaseItem];

}

class PurchaseFailedGetList extends PurchaseListState{}
