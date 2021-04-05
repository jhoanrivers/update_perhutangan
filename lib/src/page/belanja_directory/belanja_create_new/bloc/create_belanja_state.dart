


import 'package:equatable/equatable.dart';

abstract class CreateBelanjaState extends Equatable {


  @override
  List<Object> get props => [];
}


class InitialCreateBelanja extends CreateBelanjaState{}

class LoadingCreateBelanja extends CreateBelanjaState{}

class SuccessCreateBelanja extends CreateBelanjaState{}

class ErrorCreateBelanja extends CreateBelanjaState{}