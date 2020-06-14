

import 'package:equatable/equatable.dart';

abstract class PiutangEvent extends Equatable{
  const PiutangEvent();

  @override
  List<Object> get props {
    return [];
  }
}


class FetchDataPiutang extends PiutangEvent{}

class CreatePiutang extends PiutangEvent{}
