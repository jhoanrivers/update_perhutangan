


import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetUserCurrentHutPiut extends HomeEvent{}