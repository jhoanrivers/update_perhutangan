import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/model/dashboard.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialState extends ProfileState {}

class LoadingState extends ProfileState {}

class LoadingLogoutState extends ProfileState{}

class SuccessLogoutState extends ProfileState {}

class FailedLogoutState extends ProfileState {}

class SuccessFetchData extends ProfileState {
  final Account dataUser;

  SuccessFetchData({this.dataUser});

  @override
  List<Object> get props {
    return [dataUser];
  }
}

class FailedFetchData extends ProfileState {}

class LoadingEditData extends ProfileState{}

class LoginAgainAfterEditData extends ProfileState{}

class SuccessEditProfile extends ProfileState {}

class FailedEditProfile extends ProfileState{}
