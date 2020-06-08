

import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialRegister extends RegisterState{}

class LoadingRegister extends RegisterState{}

class SuccessRegister extends RegisterState{}

class ErrorRegister extends RegisterState{}


