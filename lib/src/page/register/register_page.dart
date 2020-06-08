

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/register/bloc/register_bloc.dart';
import 'package:updateperutangan/src/page/register/register_view.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterBloc(),
      child: RegisterView(),
    );
  }
}
