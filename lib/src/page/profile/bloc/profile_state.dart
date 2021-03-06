

import 'package:equatable/equatable.dart';
import 'package:updateperutangan/src/model/data.dart';

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
final DataUser dataUser;

  SuccessFetchData({this.dataUser});

  @override
  List<Object> get props {
    return [dataUser];
  }
}

class FailedFetchData extends ProfileState{}