



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_bloc.dart';
import 'package:updateperutangan/src/page/profile/profile_view.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileView(),
    );
  }
}
