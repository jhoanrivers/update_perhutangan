
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class RegisterButtonPressed extends RegisterEvent {

  final String username;
  final String name;
  final String password;
  final String ovo;
  final String gopay;
  final String dana;

  RegisterButtonPressed({
    this.ovo,
    this.gopay,
    this.dana,
    @required this.username,
    @required this.name,
    @required this.password,

  });






}


