


import 'package:equatable/equatable.dart';

abstract class CreateBelanjaEvent extends Equatable {

  @override
  List<Object> get props => [];

}


class DoCreateBelanja extends CreateBelanjaEvent {
   final String title;
   final String date;
   final List<int> members;

  DoCreateBelanja({this.title, this.date, this.members});


   @override
   List<Object> get props =>[title, date, members];

}