

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props {
    return [];
  }
}


class LoginButtonPressed extends LoginEvent{
  final String username;
  final String password;
  final String userToken;

  LoginButtonPressed({@required this.userToken, @required this.username,@required this.password});

  @override
  List<Object> get props {
    return [username,password, userToken];
  }
}