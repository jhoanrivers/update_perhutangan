


import 'package:equatable/equatable.dart';

abstract class AddPurchaseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class AddPurchaseInitial extends AddPurchaseState{}

class AddPurchaseLoading extends AddPurchaseState{}

class AddPurchaseSuccess extends AddPurchaseState{}

class AddPurchaseFailed extends AddPurchaseState{}