

import 'package:equatable/equatable.dart';

abstract class HutangEvent extends Equatable{
  const HutangEvent();

  @override
  List<Object> get props {
    return [];
  }
}


class FetchAllHutang extends HutangEvent{}