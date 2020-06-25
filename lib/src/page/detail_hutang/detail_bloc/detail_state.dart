import 'package:equatable/equatable.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class InitialState extends DetailState {}

class LoadingState extends DetailState {}

class SuccessState extends DetailState {}

class ErrorState extends DetailState {}
