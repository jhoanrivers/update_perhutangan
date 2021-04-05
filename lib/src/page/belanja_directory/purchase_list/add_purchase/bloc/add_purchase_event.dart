

import 'package:equatable/equatable.dart';

abstract class AddPurchaseEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class AddPurchaseItem extends AddPurchaseEvent {
  final int id;
  final String name;
  final String price;

  AddPurchaseItem({this.id, this.name, this.price});

  @override
  // TODO: implement props
  List<Object> get props => [id, name, price];
}