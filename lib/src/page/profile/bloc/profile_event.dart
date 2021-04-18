
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:updateperutangan/src/model/account.dart';

abstract class ProfileEvent extends Equatable{
  const ProfileEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class UserLogoutEvent extends ProfileEvent{}


class UserFetchData extends ProfileEvent{}


class EditProfileEvent extends ProfileEvent{
  final Account dataAccount;

  EditProfileEvent({@required this.dataAccount});

  @override
  List<Object> get props => [dataAccount];
}