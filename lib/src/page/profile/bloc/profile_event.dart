
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable{
  const ProfileEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class UserLogoutEvent extends ProfileEvent{}


class UserFetchData extends ProfileEvent{}
