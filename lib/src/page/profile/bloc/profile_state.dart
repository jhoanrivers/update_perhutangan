

import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/account.dart';

abstract class ProfileState extends Equatable{
  const ProfileState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialState extends ProfileState{}

class LoadingState extends ProfileState{}

class SuccessLogoutState extends ProfileState{}

class FailedLogoutState extends ProfileState{}

class SuccessFetchData extends ProfileState{
  final Account account;

  SuccessFetchData({this.account});

  @override
  List<Object> get props {
    return [account];
  }
}

class FailedFetchData extends ProfileState{}