import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class ActionForRequest extends DetailEvent {
  final int loan_id;
  final String status_loan;

  ActionForRequest({@required this.loan_id, @required this.status_loan});

  @override
  List<Object> get props => [loan_id, status_loan];
}
