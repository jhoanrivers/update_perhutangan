

import 'package:equatable/equatable.dart';

abstract class PiutangState extends Equatable {
  const PiutangState();

  @override
  List<Object> get props {
    return [];
  }
}



class InitialState extends PiutangState{}

class LoadingState extends PiutangState{}

class SuccessFetchPiutang extends PiutangState{
  //List data piutang

}

class SuccessCreatePiutang extends PiutangState{}

class ErrorCreatePiutang extends PiutangState{}

class ErrorFetchPiutang extends PiutangState{}
