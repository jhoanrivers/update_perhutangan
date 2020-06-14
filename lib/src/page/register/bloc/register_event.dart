
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

  RegisterButtonPressed({
    @required this.ovo,
    @required this.gopay,
    @required this.username,
    @required this.name,
    @required this.password,

  });






}


