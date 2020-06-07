

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object> get props {
    return [];
  }
}


class InitialLogin extends LoginState{}

class LoadingLogin extends LoginState{}

class SuccessLogin extends LoginState{}

class ErrorLogin extends LoginState{}