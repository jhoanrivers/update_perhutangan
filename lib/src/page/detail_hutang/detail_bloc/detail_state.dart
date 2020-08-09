import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class InitialState extends DetailState {}

class LoadingState extends DetailState {}

class SuccessState extends DetailState {
  String status;

  SuccessState({@required this.status});

  @override
  List<Object> get props => [status];

}

class ErrorState extends DetailState {}
