



import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BelanjaEvent extends Equatable {
  const BelanjaEvent();

  @override
  List<Object> get props => [];

}



// ignore: camel_case_types
class GetListBelanja extends BelanjaEvent {

  GetListBelanja({
    @required this.start,
    @required this.finish
  });

  int start;
  int finish;

  @override
  List<Object> get props => [start, finish];
}